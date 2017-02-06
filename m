Received: from eggs.gnu.org ([2001:4830:134:3::10]:32983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1caiJE-0005M9-5l
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1caiJA-0006YH-8h
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:22:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1caiJA-0006Y5-2w
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:22:12 -0500
References: <20170206112953.16993-1-berrange@redhat.com>
	<CAFEAcA_UVfxkRa7ESxXJGLLhT_K-=pnB_NJ53mW687ibxmhSmg@mail.gmail.com>
	<20170206120515.GJ3029@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <221a40d6-9688-d384-0d59-5b0fefe8206e@redhat.com>
Date: Mon, 6 Feb 2017 13:22:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170206120515.GJ3029@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] rules: don't try to create missing include
 dirs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 06/02/2017 13:05, Daniel P. Berrange wrote:
>>>          $(shell mkdir -p ./ $(sort $(dir $($v))))
>>> -        $(shell cd $(BUILD_DIR) && mkdir -p ./ $(sort $(dir $($v))))
>> I know this is the same syntax as the existing line above
>> and we're deleting it anyway, but what does it actually do?
>> When does telling mkdir to create "./" make sense?
> No idea why the ./ was there originally - it appears to serve no
> purpose. The useful bit is the stuff afterwards - the $($v) bit.
> It gets populated based on the variable being unnested. For example
> 
>    block-obj-y = block.o blockjob.o block/ nbd/
> 
> will make $v contain  "block nbd", hence cause creation of those
> dirs in the the build dir.

"mkdir -p" with no arguments gives an error, the "./" shuts it up.

Paolo
