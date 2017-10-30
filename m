Received: from eggs.gnu.org ([2001:4830:134:3::10]:37750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9AwO-0002gK-3m
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9AwK-0005hy-81
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:21:24 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:48154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9AwK-0005ho-1s
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:21:20 -0400
Received: by mail-wr0-x242.google.com with SMTP id 15so12786416wrb.5
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 07:21:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f244049d-c103-e657-dfec-95507ffc7b3e@mips.com>
References: <1508769996-5747-1-git-send-email-yongbok.kim@imgtec.com>
	<f244049d-c103-e657-dfec-95507ffc7b3e@mips.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 14:20:58 +0000
Message-ID: <CAFEAcA_5j+xUrkBUCDG18o760EJxzwncCR5UjHX+S3oM3K3Xzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] MIPS queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 October 2017 at 14:09, Yongbok Kim <yongbok.kim@mips.com> wrote:
> On 23/10/2017 15:46, Yongbok Kim wrote:
>>
>> The following changes since commit
>> e822e81e350825dd94f41ee2538ff1432b812eb9:
>>
>>    Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'
>> into staging (2017-10-20 15:04:00 +0100)
>>
>> are available in the git repository at:
>>
>>    git://github.com/yongbok/upstream-qemu.git target-mips.next
>>
>> ----------------------------------------------------------------
>> MIPS patches 2017-10-23
>>
>> Changes:
>> Update email addresses of Yongbok Kim, James Hogan and Paul Burton.
>>
>> ----------------------------------------------------------------
>>
>> James Hogan (1):
>>    MAINTAINERS: Update James Hogan's email address
>>
>> Paul Burton (1):
>>    MAINTAINERS: Update Paul Burton's email address
>>
>> Yongbok Kim (1):
>>    MAINTAINERS: Update Yongbok Kim's email address
>>
>>   .mailmap    |    3 +++
>>   MAINTAINERS |   10 +++++-----
>>   2 files changed, 8 insertions(+), 5 deletions(-)
>>
>>
>
> Ping?

I only notice pull requests if they contain the magic words
"for you to fetch changes up to", which yours does not.
'git request-pull' includes this in its output, so you should
probably make sure your workflow is using that.

I tried applying this, but git complains:
error: remotes/yongbok/target-mips.next: cannot verify a non-tag
object of type commit.

Pull requests should quote a gpg-signed tag name, not a branch.

thanks
-- PMM
