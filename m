Received: from eggs.gnu.org ([2001:4830:134:3::10]:44415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cVe2o-0001Mt-Ob
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cVe2k-0001sw-HL
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:48:22 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cVe2k-0001sf-AS
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:48:18 -0500
Received: by mail-wm0-x232.google.com with SMTP id c206so153426573wme.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 04:48:18 -0800 (PST)
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
	<CAFEAcA-fSJ5PfpKFaehruzjidBtmQP_435WLqgSLg=cQiETR8Q@mail.gmail.com>
	<878tq5looy.fsf@dusky.pond.sub.org>
	<CAFEAcA8ckibWjvDQGyBTGSGmrZQGUbojQmuHqnm=EPg=Vh7L1g@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8ckibWjvDQGyBTGSGmrZQGUbojQmuHqnm=EPg=Vh7L1g@mail.gmail.com>
Date: Mon, 23 Jan 2017 12:48:14 +0000
Message-ID: <871svuaqnl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 20 January 2017 at 15:46, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 17 January 2017 at 16:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> In any case, applied this pullreq to master.
>>>
>>> Although it works fine on my OSX box (with warnings) it seems
>>> to have broken the Travis OSX builds:
>>> https://travis-ci.org/qemu/qemu/jobs/192750574
>>>
>>>   GEN     qemu-options.texi
>>>   GEN     qemu-monitor.texi
>>>   GEN     qemu-img-cmds.texi
>>>   GEN     qemu-monitor-info.texi
>>>   GEN     qemu-doc.txt
>>> qemu-doc.texi:7: warning: unrecognized encoding name `UTF-8'.
>>>   GEN     qemu-img.1
>>> /Users/travis/build/qemu/qemu//qemu-options.texi:60: warning: unlikely
>>> character [ in @var.
>>> /Users/travis/build/qemu/qemu//qemu-options.texi:60: warning: unlikely
>>> character ] in @var.
>>> /Users/travis/build/qemu/qemu//qemu-options.texi:61: warning: unlikely
>>> character [ in @var.
>>> /Users/travis/build/qemu/qemu//qemu-options.texi:61: warning: unlikely
>>> character ] in @var.
>>> /Users/travis/build/qemu/qemu//qemu-options.texi:630: No matching `@end table'.
>>> /Users/travis/build/qemu/qemu//qemu-doc.texi:1419: Cross reference to
>>> nonexistent node `bt-hcis' (perhaps incorrect sectioning?).
>>> makeinfo: Removing output file `qemu-doc.txt' due to errors; use
>>> --force to preserve.
>>> make: *** [qemu-doc.txt] Error 1
>>
>> @table and @end table are nested correctly in my generated
>> qemu-options.texi, and @anchor{bt-hcis} is present.  Can you grab the
>> offending qemu-options.texi for me?
>
> Alex may know how to get objects out of a failed Travis build
> (if it's possible at all).

For the normal targets we can re-create builds at our leisure using the
travis docker image. Unfortunately I'm not clear on how this works for
the MacOSX build.

The best solution I can come up with is to tweak your build to dump the
.text into stdout and then look on the Travis web-page as the build
fails. I had a similar fall-back encoded when debugging the clang build,
something like:

      before_script:
        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log

So change your local .travis.yml to:

    - env: CONFIG=""
      os: osx
      compiler: clang
      script: make -j3 || cat qemu-options.texi

and trigger a build with it.

--
Alex Bennée
