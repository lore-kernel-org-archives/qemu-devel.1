Received: from eggs.gnu.org ([2001:4830:134:3::10]:47682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1esmTi-0003Ld-OV
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1esmTd-0001Tk-2N
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:32:18 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1esmTc-0001TP-U4
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:32:12 -0500
Received: by mail-qk0-f194.google.com with SMTP id 130so19753737qkd.13
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 01:32:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Mar 2018 10:32:11 +0100
Message-ID: <CAMxuvayTFjQU3_W_LH1ETVexm8PHrNZpP2OJt+ufnrCnGjkrsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] Convert the TPM code to use tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Sun, Mar 4, 2018 at 10:56 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> This series of patches converts the TPM code to use tracing rather
> than the #define DEBUG_XYZ type of debugging.
>
> Regards,
>    Stefan
>
> Stefan Berger (5):
>   tpm: convert tpm_crb.c to use trace-events
>   tpm: convert tpm_passthrough.c to use trace-events
>   tpm: convert tpm_util.c to use trace-events
>   tpm: convert tpm_emulator.c to use trace-events
>   tpm: convert tpm_tis.c to use trace-events

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
>  Makefile.objs            |  1 +
>  hw/tpm/tpm_crb.c         | 17 +++------
>  hw/tpm/tpm_emulator.c    | 45 +++++++++++-----------
>  hw/tpm/tpm_passthrough.c | 13 ++-----
>  hw/tpm/tpm_tis.c         | 98 ++++++++++++++++++++++--------------------=
------
>  hw/tpm/tpm_util.c        | 29 ++++++--------
>  hw/tpm/trace-events      | 46 +++++++++++++++++++++++
>  7 files changed, 135 insertions(+), 114 deletions(-)
>  create mode 100644 hw/tpm/trace-events
>
> --
> 2.5.5
>
