Received: from eggs.gnu.org ([2001:4830:134:3::10]:52191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7dT6-0005ht-S4
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7dT5-0003sI-GM
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:29:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7dT2-0003qZ-Oy
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:29:16 -0400
Received: by mail-oi1-x241.google.com with SMTP id u197-v6so3943108oif.5
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 02:29:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c1365d28-d78b-40d3-95dc-a1f507c46948@redhat.com>
References: <20181001132036.7919-1-peter.maydell@linaro.org>
	<c1365d28-d78b-40d3-95dc-a1f507c46948@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Oct 2018 10:28:52 +0100
Message-ID: <CAFEAcA-RNw=1DaNc0-O4A6W55yyBUKHDKbAt8VSjuoG0Vec0iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests: Disable
 test-bdrv-drain and test-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Max Reitz <mreitz@redhat.com>

On 2 October 2018 at 21:11, John Snow <jsnow@redhat.com> wrote:
>
>
> On 10/01/2018 09:20 AM, Peter Maydell wrote:
>> The test-bdrv-drain and test-replication tests have
>> intermittent errors which make my build testing process
>> fail way too often. Disable them both for the moment.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> Should we leave some kind of breadcrumb to remind ourselves to fix or
> re-enable these for the 3.1 RC window?

Some fixes attempting to fix the tests have gone in instead
of this patch. There does still seem to be a problem with
test-bdrv-drain on OSX though.

thanks
-- PMM
