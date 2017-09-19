Received: from eggs.gnu.org ([2001:4830:134:3::10]:39528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1du6Fz-0002xc-KY
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1du6Fw-0000bP-Ci
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:19:19 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1du6Fw-0000b7-5e
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:19:16 -0400
Received: by mail-pf0-x242.google.com with SMTP id q76so803984pfq.5
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 17:19:16 -0700 (PDT)
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<c7702271-0af0-d33d-5ebe-364ce75a68df@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ea2a1b2f-4b44-0eb2-2fef-bb8eec118693@ozlabs.ru>
Date: Tue, 19 Sep 2017 10:19:11 +1000
MIME-Version: 1.0
In-Reply-To: <c7702271-0af0-d33d-5ebe-364ce75a68df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 00/13] memory: Reduce memory use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 19/09/17 00:59, Paolo Bonzini wrote:
> On 18/09/2017 12:16, Alexey Kardashevskiy wrote:
>> This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593
>> Previous versions:
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01559.html
>> v2: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04069.html
>>
>> This patchset tries to reduce amount of memory used by FlatViews
>> and tries share as many FVs between address spaces as possible.
>>
>> Changelog:
>> v3:
>> * addressed comments from v2, mainly simplified the code
> 
> Looks almost ready.  I had a couple comments on patch 11.  However, if
> they are wrong, I can just queue patches 2-13 immediately. 

Nah, I'll repost, too many commit logs need an update. Thanks for the review!


-- 
Alexey
