Received: from eggs.gnu.org ([2001:4830:134:3::10]:39922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnj70-0008JK-QX
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnj6z-0006PX-St
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:51:26 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnj6z-0006PK-Mc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:51:25 -0400
Received: by mail-wr0-x233.google.com with SMTP id u108so120032722wrb.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 02:51:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314092931.GB3952@noname.str.redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
	<CAFEAcA9JoOLtUJAVhXijjDVZ4iTH_kYc3r03zmq7R58BesO1Jg@mail.gmail.com>
	<20170314092931.GB3952@noname.str.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 10:51:04 +0100
Message-ID: <CAFEAcA800xtdyactwOctU+_5jJ64Y78Vv9obE3=Bzaer3CSxVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/12] Block layer fixes for 2.9.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 March 2017 at 10:29, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 13.03.2017 um 19:05 hat Peter Maydell geschrieben:
>> On 13 March 2017 at 15:54, Kevin Wolf <kwolf@redhat.com> wrote:
>> > The following changes since commit dd4d2578215cd380f40a38028a9904e15b135ef3:
>> >
>> >   Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170309-1' into staging (2017-03-09 13:16:05 +0000)
>> >
>> > are available in the git repository at:
>> >
>> >
>> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>> >
>> > for you to fetch changes up to dcbf37ce41a52698550f8f8b2f14b5e6fee22d2d:
>> >
>> >   commit: Implement .bdrv_refresh_filename (2017-03-13 12:49:33 +0100)
>> >
>> > ----------------------------------------------------------------
>> > Block layer fixes for 2.9.0-rc1
>>
>> We haven't had rc0 yet :-)
>
> I was assuming that we'd just skip -rc0 then. Are we instead shifting
> the release by a week or two?

I'm planning to push all the rcs back a week. Of course
if we get to rc1/rc2 and there's very little going into the
tree we can release early, but this basically never happens.

thanks
-- PMM
