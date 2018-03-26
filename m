Received: from eggs.gnu.org ([2001:4830:134:3::10]:48718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0OHI-0005rw-O6
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0OHF-0005AE-Jz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:18:56 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:39565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0OHF-00057J-De
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:18:53 -0400
Received: by mail-wm0-x234.google.com with SMTP id f125so14003726wme.4
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 02:18:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-2-mdavidsaver@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bcf8f900-42a0-0eb0-9aeb-f688038d313b@redhat.com>
Date: Mon, 26 Mar 2018 11:18:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-2-mdavidsaver@gmail.com>
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
To: Michael Davidsaver <mdavidsaver@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 24/03/2018 20:24, Michael Davidsaver wrote:
> Test current time and set+get round trip.
> Separate current time test from set/get
> tests to avoid test order issues.

What are these issues?  You can start a different QEMU for each test.

Paolo

> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
