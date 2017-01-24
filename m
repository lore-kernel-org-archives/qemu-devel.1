Received: from eggs.gnu.org ([2001:4830:134:3::10]:33733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVyxx-00082g-Jm
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVyxw-00028I-7i
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:08:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cVyxv-00027u-Vq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:08:44 -0500
From: Markus Armbruster <armbru@redhat.com>
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
	<87mvegu6m4.fsf@dusky.pond.sub.org>
	<CAFEAcA8kjKnc_GM_4YRxjek5V04CSTEQDGvX_jbq662H=279pw@mail.gmail.com>
Date: Tue, 24 Jan 2017 12:08:40 +0100
In-Reply-To: <CAFEAcA8kjKnc_GM_4YRxjek5V04CSTEQDGvX_jbq662H=279pw@mail.gmail.com>
	(Peter Maydell's message of "Tue, 24 Jan 2017 10:03:09 +0000")
Message-ID: <87inp4d8av.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, =?utf-8?Q?Marc?= =?utf-8?Q?-Andr=C3=A9?= Lureau <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 24 January 2017 at 09:53, Markus Armbruster <armbru@redhat.com> wrote:
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
>> Are you *sure* this series causes the failure?
>
> It's pretty solidly looking like it in travis: everything
> passes up until this merge is applied, and then everything
> fails...
>
>> I generated qemu-options.texi for every merge commit since v2.8.0, and
>> the only one that changes it is commit 598cf1c "Merge remote-tracking
>> branch 'remotes/bonzini/tags/for-upstream' into staging".
>
> Travis was already failing with this error before 598cf1c.
> First build with this error was on commit 23eb9e6; the build on
> the merge before that was fine.
> https://travis-ci.org/qemu/qemu/jobs/192750574
> is the build log for the first failure.
> https://travis-ci.org/qemu/qemu/jobs/192689212
> is the build log for the previous success.

Yeah, that's conclusive.

> I do note one difference: the successful build does not appear
> to try to build qemu-doc.txt. Perhaps your merge enabled
> an attempt to build some flavour of the docs that has
> always been broken ?

Since .texi doesn't change, the way we process it is the most likely
suspect.  In my other message, I list three commits that affect
processing.  I need help with testing them on OS X.
