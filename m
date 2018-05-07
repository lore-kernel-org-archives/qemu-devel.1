Received: from eggs.gnu.org ([2001:4830:134:3::10]:58207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFYxi-00021L-3a
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFYxe-0007re-Ue
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:45:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fFYxe-0007rS-QQ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 01:45:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CBC9A2030
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 05:45:19 +0000 (UTC)
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com>
	<87wowgyqj8.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <32c5b770-3bbf-e9d2-ea78-023986ba828f@redhat.com>
Date: Mon, 7 May 2018 07:45:12 +0200
MIME-Version: 1.0
In-Reply-To: <87wowgyqj8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Removal of deprecated -no-kvm*
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 07.05.2018 07:37, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 04/05/2018 19:01, Thomas Huth wrote:
>>> The -no-kvm* options are a remainder of the ancient "qemu-kvm"
>>> fork. They have never been officially documented in our qemu-doc,
>>> they have been marked as deprecated in the sources since a very
>>> long time, and we've marked them as deprecated in our qemu-doc
>>> since QEMU v2.10. So far I haven't seen any complaints that we
>>> should keep them, so it's time to remove these old parameters now.
>>>
>>> While I'm at it, this patch series also removes a left-over from
>>> the "-tdf" option (which has been removed with QEMU v2.12) and
>>> fixes a deficiency in the option parsing code that has been
>>> revealed by the remainder of the "-tdf" option.
>>>
>>> Thomas Huth (5):
>>>   qemu-options: Remove remainders of the -tdf option
>>>   qemu-options: Bail out on unsupported options instead of silently
>>>     ignoring them
>>>   qemu-options: Remove deprecated -no-kvm-pit-reinjection
>>>   qemu-options: Remove deprecated -no-kvm-irqchip
>>>   qemu-options: Remove deprecated -no-kvm
>>
>> I'm not that sure anymore about -no-kvm.  It can come in handy for
>> distros (*cough* RHEL *cough) that only ship a qemu-kvm binary with
>> default accelerator "-machine accel=3Dkvm:tcg".
>>
>> Yeah, "-accel tcg" is only a few characters later, but it is a
>> relatively recent addition.
>=20
> 2012 is "relatively recent" in the alternate RHEL universe, perhaps :)

That was the "-machine accel=3Dtcg", but Paolo was rather talking about
"-accel tcg", which has been added last year. Yes, we've got three (!)
ways of dealing with accelerators now: "-M accel=3D", "-accel" and
"-enable-kvm + -no-kvm". We're very userfriendly, aren't we? ;-)

 Thomas
