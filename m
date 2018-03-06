Received: from eggs.gnu.org ([2001:4830:134:3::10]:60743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etDO7-0008Ro-R8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etDO7-0003ne-1h
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:16:19 -0500
References: <20180306134402.997-1-berrange@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <10097c87-9302-5de5-9b63-e76200989ac1@ilande.co.uk>
Date: Tue, 6 Mar 2018 14:16:00 +0000
MIME-Version: 1.0
In-Reply-To: <20180306134402.997-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] misc,
 ide: remove use of HWADDR_PRIx in trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 06/03/18 13:44, Daniel P. Berrangé wrote:

> The trace events all use a uint64_t data type, so should be using the
> corresponding PRIx64 format, not HWADDR_PRIx which is intended for use
> with the 'hwaddr' type.

Ha okay looks like you beat me to it ;)  I wonder if we can teach 
checkpatch.pl about this...


ATB,

Mark.
