Received: from eggs.gnu.org ([2001:4830:134:3::10]:57144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNJs1-0008Av-EH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNJry-000379-AJ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:47:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNJry-00036f-4l
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:47:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7145D37EEF
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 15:47:49 +0000 (UTC)
References: <cover.1542294676.git.eskultet@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49306290-125b-8d63-ae27-495c0c17e113@redhat.com>
Date: Thu, 15 Nov 2018 09:47:44 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1542294676.git.eskultet@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Introduce 'rendernode' option for
 egl-headless display type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 11/15/18 9:15 AM, Erik Skultety wrote:
> Since QEMU always picks the default DRI device, libvirt doesn't know which one
> to put into the mount namespace and relabel it accordingly, hence hitting
> permission issues, unless admin tweaks the default permissions of the DRI
> devices.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1648236

This is borderline between fixing a bug that gets in the way of libvirt 
(and thus useful for 3.1) and a feature (thus for 4.0, since we won't 
have a 3.2 release). I'll let Gerd decide.

> 
> Erik Skultety (3):
>    qapi: Add "rendernode" display option for egl-headless
>    ui: Allow specifying 'rendernode' display option for egl-headless
>    help: Provide help for egl-headless
> 
>   qapi/ui.json      | 16 +++++++++++++++-
>   qemu-options.hx   |  6 +++++-
>   ui/egl-headless.c |  2 +-
>   3 files changed, 21 insertions(+), 3 deletions(-)
> 
> --
> 2.19.1
> 
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
