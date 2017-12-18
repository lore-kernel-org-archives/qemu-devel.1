Received: from eggs.gnu.org ([2001:4830:134:3::10]:35599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eQw58-0001Ov-1B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eQw4z-0001lT-VN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:07:49 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eQw4z-0001j8-Hm
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:07:41 -0500
References: <20171121064106.13721-1-ybettan@redhat.com>
	<fe42e8d1-afde-f761-9780-b1a8f7d4030f@vivier.eu>
	<64af419e-b8b8-0a05-21f7-1029bc809079@redhat.com>
	<0843d1d9-e015-f4bd-3a98-92c0e3db5b42@vivier.eu>
	<CAFEAcA93oFez4Fvz83vye3-JjWFLMNyLKA3UL+Pck8d6eNWRaw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7d655b6e-22a7-eb24-f8ba-4ed817e4aa71@vivier.eu>
Date: Mon, 18 Dec 2017 15:07:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA93oFez4Fvz83vye3-JjWFLMNyLKA3UL+Pck8d6eNWRaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl.c && linux-user/main.c : removed **envp
 from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yoni Bettan <ybettan@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>

Le 18/12/2017 à 13:30, Peter Maydell a écrit :
> On 18 December 2017 at 07:52, Laurent Vivier <laurent@vivier.eu> wrote:
>> I think we don't need it anymore as there is no difference betweent
>> qemu_main() and main().
> 
> You need to be a bit cautious there to avoid breaking
> the OSX code in ui/cocoa.m, which has its own version
> of main() which kicks off the GUI code and then eventually
> calls qemu_main() later.

Yes, you're right. cocoa.m needs qemu_main() because there is already a
main() inside. So we can't remove qemu_main().

Thanks,
Laurent
