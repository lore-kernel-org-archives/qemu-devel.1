Received: from eggs.gnu.org ([2001:4830:134:3::10]:43134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daNbs-0005jT-Np
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daNbr-0001be-Ji
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:48:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1daNbr-0001aY-AK
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:48:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4644D40246
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:48:22 +0000 (UTC)
References: <1501075650-6971-1-git-send-email-thuth@redhat.com>
	<20170726140208.GO7620@redhat.com>
	<236fd293-5d5e-0436-afc3-599ae9de6f92@redhat.com>
	<ab87e4f9-c270-80ec-ed3d-8b315dfacef8@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b9db0cdc-f03c-dfec-cf6a-bd2b004c5c3e@redhat.com>
Date: Wed, 26 Jul 2017 16:47:42 +0200
MIME-Version: 1.0
In-Reply-To: <ab87e4f9-c270-80ec-ed3d-8b315dfacef8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a favicon.ico file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>

On 26.07.2017 16:38, Paolo Bonzini wrote:
> On 26/07/2017 16:17, Thomas Huth wrote:
>> On 26.07.2017 16:02, Daniel P. Berrange wrote:
>>> On Wed, Jul 26, 2017 at 03:27:30PM +0200, Thomas Huth wrote:
>>>> Most browsers try to download a /favicon.ico file from the web servers
>>>> which is then e.g. used in the browser tabs or bookmark lists. So let's
>>>> add such a file for the QEMU website, too. The .ico has been created
>>>> resizing the logo from http://wiki.qemu.org/Logo to 16x16 pixels.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> FYI, just having a single 'favicon.ico' file isn't generally sufficient
>>> anymore. Thanks to explosion of mobile devices there are 20+ different files
>>> that various browsers  / clients look for now :-(
>>
>> Well, yeah, but most of that is just sick. Adding things like '<link
>> rel="apple-touch-icon" .../>' to your web site is IMHO just how it
>> should *not* be done.
>> If we're afraid that the 16x16 pixel icon is not enough, I think we
>> should add an additional SVG icon, smile at the browsers that support it
>> and wait for the others to catch up.
> 
> It has the advantage of working:
> 
> ----------------- 8< -----------
> From ba78908efd551c514a5156a3882316df76bee2e4 Mon Sep 17 00:00:00 2001
> From: Thomas Huth <thuth@redhat.com>
> Date: Wed, 26 Jul 2017 15:27:30 +0200
> Subject: [qemu-web PATCH 1/1] Add a favicon file
> 
> Most browsers try to download a /favicon.ico file or similar from the
> web servers which is then e.g. used in the browser tabs or bookmark
> lists. So let's add such a file for the QEMU website, too.
> 
> The files and HTML were created with realfavicongenerator.net.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <1501075650-6971-1-git-send-email-thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  _includes/assets.html                      |   9 +++
>  assets/favicons/android-chrome-192x192.png | Bin 0 -> 23519 bytes
>  assets/favicons/android-chrome-512x512.png | Bin 0 -> 69749 bytes
>  assets/favicons/apple-touch-icon.png       | Bin 0 -> 15455 bytes
>  assets/favicons/browserconfig.xml          |   9 +++
>  assets/favicons/favicon-16x16.png          | Bin 0 -> 1356 bytes
>  assets/favicons/favicon-32x32.png          | Bin 0 -> 2363 bytes
>  assets/favicons/manifest.json              |  18 +++++
>  assets/favicons/mstile-150x150.png         | Bin 0 -> 13296 bytes
>  assets/favicons/safari-pinned-tab.svg      | 124 +++++++++++++++++++++++++++++
>  favicon.ico                                | Bin 0 -> 15086 bytes
>  11 files changed, 160 insertions(+)
>  create mode 100644 assets/favicons/android-chrome-192x192.png
>  create mode 100644 assets/favicons/android-chrome-512x512.png
>  create mode 100644 assets/favicons/apple-touch-icon.png
>  create mode 100644 assets/favicons/browserconfig.xml
>  create mode 100644 assets/favicons/favicon-16x16.png
>  create mode 100644 assets/favicons/favicon-32x32.png
>  create mode 100644 assets/favicons/manifest.json
>  create mode 100644 assets/favicons/mstile-150x150.png
>  create mode 100644 assets/favicons/safari-pinned-tab.svg
>  create mode 100644 favicon.ico

If you're willing to maintain that "mess", sure, please go ahead! But
please remove my SoB, I don't want to be responsible for all those files ;-)

 Thomas
