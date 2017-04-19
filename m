Received: from eggs.gnu.org ([2001:4830:134:3::10]:60615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d0o8B-000095-Rm
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d0o88-0000GF-Pe
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d0o88-0000Fo-Fz
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:50:40 -0400
Date: Wed, 19 Apr 2017 12:50:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170419115036.GK4019@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
	<20170419134147.458e4eb7.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170419134147.458e4eb7.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add
 guest-network-get-interface-stat command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Wed, Apr 19, 2017 at 01:41:47PM +0200, Cornelia Huck wrote:
> On Thu, 20 Apr 2017 00:57:08 +0800
> ZhiPeng Lu <lu.zhipeng@zte.com.cn> wrote:
> 
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index a02dbf2..60111dc 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1042,3 +1042,37 @@
> >    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
> >                 '*input-data': 'str', '*capture-output': 'bool' },
> >    'returns': 'GuestExec' }
> > +##
> > +# @GuestNetworkInterfaceStat:
> > +#
> > +# @rx_bytes: received bytes of interface
> > +#
> > +# @rx_packets: received packets of interface
> > +#
> > +# @rx_errs: received error packets of interface
> > +# @rx_drop: received drop packets of interface
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'struct': 'GuestNetworkInterfaceStat',
> > +  'data': {'rx_bytes': 'uint64',
> > +            'rx_packets': 'uint64',
> > +            'rx_errs': 'uint64',
> > +            'rx_drop': 'uint64',
> > +            'tx_bytes': 'uint64',
> > +            'tx_packets': 'uint64',
> > +            'tx_errs': 'uint64',
> > +            'tx_drop': 'uint64'
> > +           } }
> > +##
> > +# @guest-network-get-interface-stat:
> > +#
> > +# Get list of interface stat
> > +#
> > +# Returns: List of GuestNetworkInterfaceStat on success.
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'command': 'guest-network-get-interface-stat',
> > +  'data':    {'bus': 'int64', 'slot': 'int64', 'function': 'int64','netname':'str'},
> > +  'returns': ['GuestNetworkInterfaceStat'] }
> 
> Disregarding the question whether this command should be added to the
> guest agent (I'll leave that to others to discuss), I don't think it's
> a good idea to enshrine pci identifiers here, as it means that we would
> need to add a new interface for every non-pci network device.
> 
> Can you use a more general device identifier interface? It's fine to
> only support pci for now (as that is likely your use case anyway), but
> there should be a way to extend this in the future.

It would be better to match the identification approach uses for the
existing guest-network-get-interfaces command, which is based on MAC
address. Arguably the stats data could just be added to this existnig
command instead of adding a new command.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
