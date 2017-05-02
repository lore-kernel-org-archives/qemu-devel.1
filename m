Received: from eggs.gnu.org ([2001:4830:134:3::10]:35569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d5daY-0004Zo-Gu
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d5daV-0003Rb-Bj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:35:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d5daU-0003Qm-V2
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:35:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42JYNwS083993
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 15:35:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a700es3nf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 15:35:53 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 2 May 2017 15:35:51 -0400
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
	<CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 2 May 2017 15:35:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
Message-Id: <b6e0d6d2-d276-c66d-ae5e-c6502cbe0b5c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Patrick Ohly <patrick.ohly@intel.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

On 05/02/2017 02:50 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Tue, May 2, 2017 at 10:25 PM Patrick Ohly <patrick.ohly@intel.com=20
> <mailto:patrick.ohly@intel.com>> wrote:
>
>     On Tue, 2017-05-02 at 13:19 -0400, Stefan Berger wrote:
>     > On 05/02/2017 01:09 PM, Marc-Andr=C3=A9 Lureau wrote:
>     > > On Tue, May 2, 2017 at 8:59 PM Stefan Berger
>     <stefanb@linux.vnet.ibm.com <mailto:stefanb@linux.vnet.ibm.com>>
>     > > wrote:
>     > >
>     > >> And who is going to implement that qemu-swtpm? Obviously this
>     discussion
>     > >> doesn't contribute to progress if nobody is doing that in the
>     end.
>     > >>
>     > > The same persons who try to push for that emulated TPM code.
>     The easiest
>     > > approach would be to copy/adapt the swtpm code in qemu, if the
>     licence is
>     > > compatible. I can help with that if there is a consensus it's
>     a better
>     > > approach.
>     >
>     >
>     > It's a matter of time and at least I don't have time for that.
>
>     Neither do I, and nor (I believe) does Amarnath. The approach with
>     using
>     the existing swtpm project seemed attractive to us exactly because =
it
>     avoids having to write and maintain more than just the glue code
>     between
>     the two projects.
>
>
> The main argument is not about having more or less code in qemu to=20
> maintain, but yes this is a concern (although giving up that=20
> maintenance to a seperate project with mostly Stefan-alone isn't a=20
> much better alternative). btw, is the project actually used by=20
> something else than qemu? (I am not talking about=20
> developpers/testing). If not, then it makes sense to make it part of qe=
mu.

The intention would be to use it for RunC as well (plus higher layers=20
afterwards): https://github.com/opencontainers/runc/pull/1082

>
> But it's mostly a technical reason, to avoid having to rely on a=20
> foreign protocol and project with all the compatibility constrains.

I understand. Ideally swtpm-0.1 would be equivalent to 1.0 with all=20
features available and no further protocol extensions necessary. In=20
practice that may look different.

>
> In the end, we may decide to start with a separate project, and change=20
> it in the future if it's problematic (that would break some cases,=20
> such as being able to freely switch the helper). Tbh, I am not so=20
> happy with the code quality of swtpm, and I haven't looked closely at=20
> libtpms. Having a qemu-swtpm as part of qemu would probably help=20
> improve it too, and bring a few more developers for maintainance...

libtpms combines a few source codes with some glue around it. The coding=20
style is different for TPM 1.2 and TPM 2 code for example and the code=20
bases are in the 10s of thousands of line. In the case of TPM 2 it=20
'lives from' TCG code drops and thus there is no reformatting of source=20
code etc.

If someone wants to get started on qemu-swtpm that's certainly cool but=20
over the years it's just been quite difficult to find developers for it=20
to share the burden. All that said, someone should state whether this=20
series is a go or no-go because of the external project it requires.
