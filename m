Received: from eggs.gnu.org ([209.51.188.92]:36819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YVU-0003A3-Ng
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2YVU-0007jB-0o
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:43:04 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:53605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h2YVT-0007iN-LY
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:43:03 -0500
References: <20190306031221.GA53@03612eec87fc>
	<20190306044620.GC75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3ccb5a7c-9b64-d380-0c3b-e755c612c31f@vivier.eu>
Date: Sat, 9 Mar 2019 10:42:36 +0100
MIME-Version: 1.0
In-Reply-To: <20190306044620.GC75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/10] qemu-binfmt-conf.sh: add
 QEMU_CREDENTIAL and QEMU_PERSISTENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, eblake@redhat.com

On 06/03/2019 05:46, Unai Martinez-Corral wrote:
> Allow to set options '--persistent' and/or '--credential' through
> environment variables. If not defined, defaults are used ('no').
> Anyway, command-line arguments have priority over environment variables.
> 

Could you explain why we could need to use the env variable instead of
the command line parameter?

I don't see any use case for that.

Thanks,
Laurent
