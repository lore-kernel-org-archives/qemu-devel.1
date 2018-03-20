Received: from eggs.gnu.org ([2001:4830:134:3::10]:60817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyFwJ-0005Rh-OJ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyFwD-0008KA-Jp
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:00:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51444 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyFwD-0008Ik-FV
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:00:21 -0400
References: <20180316170020.8212-1-vkuznets@redhat.com>
	<20180316170020.8212-2-vkuznets@redhat.com>
	<20180319170603.GA12962@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4974d25-de6f-7a88-4416-faa6764a76cc@redhat.com>
Date: Tue, 20 Mar 2018 13:00:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180319170603.GA12962@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On 19/03/2018 18:06, Roman Kagan wrote:
>> +        if (has_msr_hv_reenlightenment) {
>> +            env->features[FEAT_HYPERV_EAX] |=3D
>> +                HV_ACCESS_REENLIGHTENMENTS_CONTROL;
>> +        }
> Can you please add a matching comment to the definition of
> feature_word_info[FEAT_HYPERV_EAX].feat_names[]?
>=20
> Also there appears to be no cpu property to turn this on/off, does it?
> It's enabled based only on the support in the KVM it's running against.
> So I guess we may have a problem migrating between the hosts with
> different KVM versions, one supporting it and the other not.
> (This is also a problem with has_msr_hv_frequencies, and is in general =
a
> long-standing issue of hv_* properties being done differently from the
> rest of CPUID features.)

Yeah, so far for frequencies that was okay or at least okay-ish because
Windows didn't use it by default without invtsc (disables migration).

However, we do need a new hv_reenlight property; if it is not set, QEMU
should behave as if the reenlightenment MSRs are not provided by KVM.

Thanks,

Paolo
