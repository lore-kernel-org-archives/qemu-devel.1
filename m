Received: from eggs.gnu.org ([2001:4830:134:3::10]:48947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVfvu-0006Hq-7h
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVfvq-00041s-78
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:49:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cVfvp-00041n-V5
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:49:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87pojmjdep.fsf@dusky.pond.sub.org>
	<CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
	<87h94x99e4.fsf@dusky.pond.sub.org>
	<CAFEAcA8vRw=13Lj_98A+3NovSeTg6e0xBopdz9EcdEeUMjjZow@mail.gmail.com>
	<874m0x7ra2.fsf@dusky.pond.sub.org>
	<CAFEAcA_txNPj6JNDavmCREse98XTkQgiFAqx5Vf8KCCu9V-6mQ@mail.gmail.com>
	<878tq93guz.fsf@dusky.pond.sub.org>
	<CAFEAcA-zV8RWCXMCbAHLMEM1oEw7CWT_aDrTc49Xv_wSnMeAyw@mail.gmail.com>
	<CAFEAcA-fSJ5PfpKFaehruzjidBtmQP_435WLqgSLg=cQiETR8Q@mail.gmail.com>
	<878tq5looy.fsf@dusky.pond.sub.org> <20170123135915.GF2853@redhat.com>
Date: Mon, 23 Jan 2017 15:49:14 +0100
In-Reply-To: <20170123135915.GF2853@redhat.com> (Daniel P. Berrange's message
	of "Mon, 23 Jan 2017 13:59:15 +0000")
Message-ID: <87tw8pbzmd.fsf@dusky.pond.sub.org>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Fri, Jan 20, 2017 at 04:46:05PM +0100, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> 
>> > On 17 January 2017 at 16:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>> >> In any case, applied this pullreq to master.
>> >
>> > Although it works fine on my OSX box (with warnings) it seems
>> > to have broken the Travis OSX builds:
>> > https://travis-ci.org/qemu/qemu/jobs/192750574
>> >
>> >   GEN     qemu-options.texi
>> >   GEN     qemu-monitor.texi
>> >   GEN     qemu-img-cmds.texi
>> >   GEN     qemu-monitor-info.texi
>> >   GEN     qemu-doc.txt
>> > qemu-doc.texi:7: warning: unrecognized encoding name `UTF-8'.
>> >   GEN     qemu-img.1
>> > /Users/travis/build/qemu/qemu//qemu-options.texi:60: warning: unlikely
>> > character [ in @var.
>> > /Users/travis/build/qemu/qemu//qemu-options.texi:60: warning: unlikely
>> > character ] in @var.
>> > /Users/travis/build/qemu/qemu//qemu-options.texi:61: warning: unlikely
>> > character [ in @var.
>> > /Users/travis/build/qemu/qemu//qemu-options.texi:61: warning: unlikely
>> > character ] in @var.
>> > /Users/travis/build/qemu/qemu//qemu-options.texi:630: No matching `@end table'.
>> > /Users/travis/build/qemu/qemu//qemu-doc.texi:1419: Cross reference to
>> > nonexistent node `bt-hcis' (perhaps incorrect sectioning?).
>> > makeinfo: Removing output file `qemu-doc.txt' due to errors; use
>> > --force to preserve.
>> > make: *** [qemu-doc.txt] Error 1
>> 
>> @table and @end table are nested correctly in my generated
>> qemu-options.texi, and @anchor{bt-hcis} is present.  Can you grab the
>> offending qemu-options.texi for me?
>
> I hacked the travis.yml to add "|| cat qemu-options.texi" after the
> build fails. The output is here:
>
>   https://travis-ci.org/berrange/qemu/jobs/194471961

I fetched your branch (it's much more than just current master + the
hack), and my local build generates the exact same qemu-options.texi,
modulo line endings (I think; diff -w comes up empty).
