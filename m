Received: from eggs.gnu.org ([2001:4830:134:3::10]:51873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etWEb-00014q-Ka
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etWEX-0001Zt-JT
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:23:45 -0500
Date: Wed, 7 Mar 2018 10:23:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307102338.GI20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
	<818fe50b-c3b8-30c5-5452-2009762142c1@ilande.co.uk>
	<4e7dd0a0-ca7e-8df7-e966-95e39d34d106@redhat.com>
	<a30f9017-b43b-0425-3d20-5708523821b7@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a30f9017-b43b-0425-3d20-5708523821b7@ilande.co.uk>
Subject: Re: [Qemu-devel] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, Mar 06, 2018 at 05:56:03PM +0000, Mark Cave-Ayland wrote:
> On 06/03/18 17:47, Thomas Huth wrote:
> 
> > > It seems that the error is being raised when setting the property rather
> > > than during realize so I'm not sure what I can do to handle this. Any
> > > thoughts?
> > 
> > Does the device need to be hot-pluggable or even user_creatable at all?
> > It seems like it is also using serial_hds[] directly, so that is a good
> > indication that it is *not* user creatable. So maybe the easiest fix is
> > to simply set
> > 
> > 	dc->user_creatable = false;
> > 
> > in macio_class_init() ?
> 
> (Added Daniel to CC)
> 
> I believe it should fail anyhow during realize because both macio devices
> (newworld and oldworld) requires an object link to the PIC which won't be
> set when using device_add via the monitor as in your example.
> 
> But it still doesn't quite feel right that just setting a property value
> should abort() immediately. Daniel, any thoughts?

Setting user_creatable = false is important, as that flag is used to filter
the list of permitted devices when doing monitor readline completion for
'device_add' and when printing available devices with '-device ?'


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
