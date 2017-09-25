Received: from eggs.gnu.org ([2001:4830:134:3::10]:33112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwWl5-0001Hc-Iq
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwWl0-0002CZ-PY
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:01:27 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:53516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwWl0-0002BQ-KJ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:01:22 -0400
Received: by mail-pg0-x22b.google.com with SMTP id j70so4307172pgc.10
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 10:01:21 -0700 (PDT)
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-2-git-send-email-cota@braap.org>
	<CAJhHMCBpo1-6x9wJWE2oSv1RB=vH-WbA0RjMWYox_dtFfLAURA@mail.gmail.com>
	<20170829211649.GA9108@flamenco>
	<CAJhHMCAwpMHAiOeBZ+F2c0yKFPQxU3nU7+FGf75wOqFnYEc43w@mail.gmail.com>
	<20170922204018.GA23631@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <00656f91-760f-c46f-86dc-6c0d29192b3b@linaro.org>
Date: Mon, 25 Sep 2017 10:01:15 -0700
MIME-Version: 1.0
In-Reply-To: <20170922204018.GA23631@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/43] tcg: define CF_PARALLEL and use
 it for TB hashing along with CF_COUNT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Pranith Kumar <bobby.prani+qemu@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On 09/22/2017 01:40 PM, Emilio G. Cota wrote:
> Hi Richard,
> 
> Are you planning to get this patchset merged in this window? If so, I can
> give it a respin on top of the current master.

Yes, I do.  I've been intending to look at ...

> Anyway, before doing so we should fix the issue around CF_COUNT_MASK that
> Pranith reported:

... this one and figure out why my intuition is wrong.
I'm at Linaro Connect this week, so it may have to wait til next.


r~
