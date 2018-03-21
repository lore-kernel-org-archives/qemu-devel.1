Received: from eggs.gnu.org ([2001:4830:134:3::10]:60402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyb5q-0003Bt-P4
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 06:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyb5p-0003Yo-QW
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 06:35:42 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eyb5p-0003Xx-KO
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 06:35:41 -0400
Received: by mail-wm0-x22b.google.com with SMTP id e194so8694131wmd.3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 03:35:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521579171-26213-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521579171-26213-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 21 Mar 2018 11:35:39 +0100
Message-ID: <CAJ+F1CL64QaWi=9AiKbRE+NmTQ5-D3KXq0ca9uYC_0Q7zn3WQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] tpm: Fix initialization of a few
 flags of CRB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Mar 20, 2018 at 9:52 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Fix the initialization of a few flags of the CRB interface. I tested the =
changes
> with UEFI and it works fine. SeaBIOS needs to have the latest patches app=
lied.
>
>    Stefan
>
> Stefan Berger (4):
>   tpm: CRB: Set tpmRegValidSts flag to '1' in device reset
>   tpm: CRB: set registers to 0 by default
>   tpm: CRB: reset locAssigned upon relinquishing locality
>   tpm: CRB: query backend for TPM established flag
>
>  hw/tpm/tpm_crb.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

For 2.12?
thanks


--=20
Marc-Andr=C3=A9 Lureau
