Received: from eggs.gnu.org ([2001:4830:134:3::10]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJa6-0007GX-OJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJa3-0007VX-4u
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:54:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZJa2-0007Sw-Su
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:54:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so3501656wmj.1
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 09:54:54 -0800 (PST)
References: <20181218175122.3229-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <14d40c58-f6f5-d7f6-1cb7-eabeeecdc1b8@redhat.com>
Date: Tue, 18 Dec 2018 18:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181218175122.3229-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

On 12/18/18 6:51 PM, Philippe Mathieu-Daudé wrote:
> GCC 8 new warning prevents builds to success since quite some time.
> First report on the mailing list is in July 2018:
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03723.html
> 
> Various intents has been sent to fix this:
> - Incorrectly using g_strlcpy()
>   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03705.html
>   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03706.html
> - Using assert() and strpadcpy()
>   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03938.html

And I forgot to add here:

  This was the approch taken by the previous v2:
  https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04405.html

> - Use #pragma GCC diagnostic ignored "-Wstringop-truncation"
>   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> - adding an inline wrapper with said pragma in there
>   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> - -Wno-stringop-truncation is the makefile
>   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> - Use the 'nonstring' attribute
>   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04493.html
> 
> This series add the QEMU_NONSTRING definition and use it.
> 
> Regards,
> 
> Phil.
