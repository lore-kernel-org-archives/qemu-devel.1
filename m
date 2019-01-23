Received: from eggs.gnu.org ([209.51.188.92]:55802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmDt9-0004SN-8p
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmDt8-0000D2-50
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:27:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmDt7-0000B4-AF
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:27:58 -0500
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
Date: Wed, 23 Jan 2019 09:27:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190123080005.31078-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

On 2019-01-23 09:00, Gerd Hoffmann wrote:
> 
> This is RfC because we might look at the ordering.  On linux we probably
> want prefer alsa over oss.
Yes, please! I've run into the trap a couple of times already: OSS
headers were available, but these days the OSS compatibility kernel
modules are not loaded anymore by default. So you compile QEMU with OSS
support and then wonder why you do not get any audio output at all...

IMHO we should put OSS as last item in the list on Linux nowadays.

 Thomas
