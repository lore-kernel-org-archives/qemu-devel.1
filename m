Received: from eggs.gnu.org ([2001:4830:134:3::10]:51475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1elxbg-0007YK-0v
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1elxaa-0004ye-Uv
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:00:19 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1elxaZ-0004xj-SP
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:59:12 -0500
Received: by mail-vk0-f67.google.com with SMTP id m197so12905504vka.3
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 05:59:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180214132508.GA7545@stefanha-x1.localdomain>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180214004820.GA15103@lemon.usersys.redhat.com>
	<20180214132508.GA7545@stefanha-x1.localdomain>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 14 Feb 2018 21:58:27 +0800
Message-ID: <CAK1Eb9kbSCzwrGzXA4Tp0N-F_82vD0tzz2V_QiYLG+AUoqYYfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Wed, Feb 14, 2018 at 9:25 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Wed, Feb 14, 2018 at 08:48:20AM +0800, Fam Zheng wrote:
>> On Tue, 02/13 17:34, Stefan Hajnoczi wrote:
>> > The following changes since commit fb68096da3d35e64c88cd610c1fa42766c58e92a:
>> >
>> >   Revert "tests: use memfd in vhost-user-test" (2018-02-13 09:51:52 +0000)
>> >
>> > are available in the Git repository at:
>> >
>> >   git://github.com/stefanha/qemu.git tags/block-pull-request
>> >
>> > for you to fetch changes up to 64b01feca991e5b19a5d750ef77cdca92b68bdbb:
>> >
>> >   misc: fix spelling (2018-02-13 15:38:17 +0000)
>>
>> Did you mean "PULL" in the subject?
>
> git-publish is just obeying your profile settings:
>
> +[gitpublishprofile "default"]
> +base = master
> +prefix = PATCH
>  ^---- :)
>
> I used PULL myself in the past but am happy with using whatever we
> decide the standard should be.
>
> Shall we remove prefix from the profiles (it defaults to "PATCH" for
> regular patches and "PULL" for pull requests)?

Yes, this is a bug. In my ~/.gitconfig I had "prefix = PATCH ..." for
all other qemu-* profiles but not the main one, "qemu". When I wrote
the patch I didn't realize it is so for a reason, and "fixed" it!

Fam
