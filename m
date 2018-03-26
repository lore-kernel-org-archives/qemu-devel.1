Received: from eggs.gnu.org ([2001:4830:134:3::10]:56086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1f0V5Q-0002jw-QA
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1f0V5L-0001Rc-U3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:35:08 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:44634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1f0V5L-0001Qx-NR
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:35:03 -0400
Received: by mail-pl0-x235.google.com with SMTP id 9-v6so12260562ple.11
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 09:35:03 -0700 (PDT)
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-2-mdavidsaver@gmail.com>
	<bcf8f900-42a0-0eb0-9aeb-f688038d313b@redhat.com>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <b418e72e-81ce-4903-0536-512c7ba9f657@gmail.com>
Date: Mon, 26 Mar 2018 09:34:58 -0700
MIME-Version: 1.0
In-Reply-To: <bcf8f900-42a0-0eb0-9aeb-f688038d313b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/14] tests: more thorough tests of ds1338
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 03/26/2018 02:18 AM, Paolo Bonzini wrote:
> On 24/03/2018 20:24, Michael Davidsaver wrote:
>> Test current time and set+get round trip.
>> Separate current time test from set/get
>> tests to avoid test order issues.
> 
> What are these issues?  You can start a different QEMU for each test.

Quite right, and this is now what I do.  The previous iteration was
clever about avoiding this for ... no particular reason.
