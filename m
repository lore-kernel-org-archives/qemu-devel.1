Received: from eggs.gnu.org ([2001:4830:134:3::10]:37551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdzJa-0007dz-FK
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdzJV-0002Im-UM
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:44:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdzJV-0002HX-OR
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:44:53 -0400
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<830fab17-5ddf-fdcc-266c-27d40529b859@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29327ae2-9331-07a4-2345-4fa4b74a62db@redhat.com>
Date: Fri, 13 Jul 2018 16:44:49 +0200
MIME-Version: 1.0
In-Reply-To: <830fab17-5ddf-fdcc-266c-27d40529b859@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: konrad.wilk@oracle.com, Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com

On 13/07/2018 16:11, konrad.wilk@oracle.com wrote:
> (Apologies if this comes out as HTML, using Thunderbird instead of mutt
> here)..
>=20
>> +=C2=A0=C2=A0=C2=A0 uint64_t pred_cmd;
>> +=C2=A0=C2=A0=C2=A0 uint64_t arch_capabilities;
>=20
> Could this be 'arch_cap' ?
>=20

Why?  Intel chose a verbose name, we should not abbrev. it unnecessarily.=
 :)

Paolo
