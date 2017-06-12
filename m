Received: from eggs.gnu.org ([2001:4830:134:3::10]:55766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKMkm-0001BG-HH
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKMkl-000714-KY
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:39:24 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKMkl-00070H-Ct
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:39:23 -0400
Received: by mail-wr0-x232.google.com with SMTP id v104so91298065wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 03:39:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 11:39:01 +0100
Message-ID: <CAFEAcA83HnSBD+c+pyUot+v-yBfhFvHU1J_zAb9ZqY3f9f-Sfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] QAPI patches for 2017-06-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 June 2017 at 14:46, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 64175afc695c0672876fbbfc31b299c86d562c=
b4:
>
>   arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-0=
7 17:21:44 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-06-09
>
> for you to fetch changes up to 9f70c3652654d59a1cc0e2ef4cc5b0e541d93579:
>
>   tests/qdict: check more get_try_int() cases (2017-06-09 13:48:45 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-06-09
>

Some compilers don't like the assert(0) idiom used in qnum.c to
say "code flow doesn't reach end of function":

/home/petmay01/linaro/qemu-for-merges/qobject/qnum.c: In function
=E2=80=98qnum_get_double=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/qobject/qnum.c:162:1: error:
control reaches end of non-void function [-Werror=3Dreturn-type]
 }
 ^
/home/petmay01/linaro/qemu-for-merges/qobject/qnum.c: In function
=E2=80=98qnum_to_string=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/qobject/qnum.c:200:1: error:
control reaches end of non-void function [-Werror=3Dreturn-type]
 }
 ^

(probably older gcc; that was the w32 gcc compiler; one of
patchew's build environments fails the same way).

I think one common working idiom for this is:
int foo(void) {
   switch (whatever) {
       case X:
          return 0;
       case Y:
          return 1;
       default:
          g_assert_not_reached();
   }
}

Can you fix and resend the pullreq, please?

thanks
-- PMM
