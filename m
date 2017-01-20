Received: from eggs.gnu.org ([2001:4830:134:3::10]:43553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUaMC-00026w-Gd
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUaMB-00015z-9l
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:40:00 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:33349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUaMB-00015X-0E
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:39:59 -0500
Received: by mail-ua0-x22e.google.com with SMTP id i68so61817654uad.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:39:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-zV8RWCXMCbAHLMEM1oEw7CWT_aDrTc49Xv_wSnMeAyw@mail.gmail.com>
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	<87pojmjdep.fsf@dusky.pond.sub.org>
	<CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
	<87h94x99e4.fsf@dusky.pond.sub.org>
	<CAFEAcA8vRw=13Lj_98A+3NovSeTg6e0xBopdz9EcdEeUMjjZow@mail.gmail.com>
	<874m0x7ra2.fsf@dusky.pond.sub.org>
	<CAFEAcA_txNPj6JNDavmCREse98XTkQgiFAqx5Vf8KCCu9V-6mQ@mail.gmail.com>
	<878tq93guz.fsf@dusky.pond.sub.org>
	<CAFEAcA-zV8RWCXMCbAHLMEM1oEw7CWT_aDrTc49Xv_wSnMeAyw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 14:39:37 +0000
Message-ID: <CAFEAcA-fSJ5PfpKFaehruzjidBtmQP_435WLqgSLg=cQiETR8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2017 at 16:43, Peter Maydell <peter.maydell@linaro.org> wrote:
> In any case, applied this pullreq to master.

Although it works fine on my OSX box (with warnings) it seems
to have broken the Travis OSX builds:
https://travis-ci.org/qemu/qemu/jobs/192750574

  GEN     qemu-options.texi
  GEN     qemu-monitor.texi
  GEN     qemu-img-cmds.texi
  GEN     qemu-monitor-info.texi
  GEN     qemu-doc.txt
qemu-doc.texi:7: warning: unrecognized encoding name `UTF-8'.
  GEN     qemu-img.1
/Users/travis/build/qemu/qemu//qemu-options.texi:60: warning: unlikely
character [ in @var.
/Users/travis/build/qemu/qemu//qemu-options.texi:60: warning: unlikely
character ] in @var.
/Users/travis/build/qemu/qemu//qemu-options.texi:61: warning: unlikely
character [ in @var.
/Users/travis/build/qemu/qemu//qemu-options.texi:61: warning: unlikely
character ] in @var.
/Users/travis/build/qemu/qemu//qemu-options.texi:630: No matching `@end table'.
/Users/travis/build/qemu/qemu//qemu-doc.texi:1419: Cross reference to
nonexistent node `bt-hcis' (perhaps incorrect sectioning?).
makeinfo: Removing output file `qemu-doc.txt' due to errors; use
--force to preserve.
make: *** [qemu-doc.txt] Error 1

thanks
-- PMM
