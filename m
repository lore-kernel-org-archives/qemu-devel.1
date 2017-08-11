Received: from eggs.gnu.org ([2001:4830:134:3::10]:33122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg60z-0005Ue-OW
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg60y-00045Y-Hv
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dg60y-000453-C0
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:13:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53A62F7C32
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 09:13:55 +0000 (UTC)
Date: Fri, 11 Aug 2017 10:13:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811091342.GD2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-6-berrange@redhat.com>
	<ebc649e6-7e62-84fc-629a-d8e33aeabc6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebc649e6-7e62-84fc-629a-d8e33aeabc6d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/15] ui: use QKeyCode exclusively in
 InputKeyEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Aug 10, 2017 at 02:02:32PM -0500, Eric Blake wrote:
> On 08/10/2017 10:55 AM, Daniel P. Berrange wrote:
> > Now that keycode numbers are converted to QKeyCodes immediately
> > when creating input events, the InputKeyEvent struct can be
> > changed to only accept a QKeyCode, instead of a KeyValue.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> 
> > +++ b/qapi-schema.json
> > @@ -5747,7 +5747,7 @@
> >  # Since: 2.0
> >  ##
> >  { 'struct'  : 'InputKeyEvent',
> > -  'data'  : { 'key'     : 'KeyValue',
> > +  'data'  : { 'key'     : 'QKeyCode',
> >                'down'    : 'bool' } }
> 
> Isn't this going to break backwards-compatibility of 'input-send-event'?
> 
> I think you have to keep the public API the same, even if you make the
> conversion as early as possible to the preferred mapping form internally.

Oh urgh, I never noticed there even was an "input-send-event" command,
only "send-key".

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
