Received: from eggs.gnu.org ([209.51.188.92]:49626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guM2N-0000ow-9R
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guM2J-0008Ll-H6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:47:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guM2H-0008DL-Kg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:47:02 -0500
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<CAFEAcA89HnCL11_N9oXqwQZf=TFJdHzONg6jxy9FORNwK85OZA@mail.gmail.com>
	<CAMxuvax=wO+dGTcgxV5L0CLf9nOozgNCM7TdqPeyj09=th0Jgw@mail.gmail.com>
	<CAFEAcA9m9CgfOsE5hVcQpWFvX7Pq9wVWiC3jf2Yr0SrXQPnTKg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95b82190-43f4-7b41-c1ee-10192f06b996@redhat.com>
Date: Thu, 14 Feb 2019 19:46:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9m9CgfOsE5hVcQpWFvX7Pq9wVWiC3jf2Yr0SrXQPnTKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/11] Enable build and install of our rST
 docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 14/02/19 16:24, Peter Maydell wrote:
> It does check, but I forgot to make the makefiles pay attention
> to the check.
> 
> That's very irritating that Fedora is using a weird filename for
> the tool -- what is their justification for doing that?
> I suppose we'll have to make configure cope :-(

They do have sphinx-build but it uses Python 2.  If you only install the
Python 3 version, you get sphinx-build-3.

I think it will be switched in Fedora 30, but I'm not sure.

Paolo
