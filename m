Received: from eggs.gnu.org ([2001:4830:134:3::10]:40792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fzXjd-0001bf-IJ
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fzXjY-0004RF-FE
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:44:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:61804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fzXjY-0004Q3-52
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:44:52 -0400
Message-ID: <1536630287.4003.1.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Tue, 11 Sep 2018 09:44:47 +0800
In-Reply-To: <20180910173817.GC12698@habkost.net>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-4-git-send-email-robert.hu@linux.intel.com>
	<9e06fe89-2688-1e6e-16ec-d5e8cdc87ce4@redhat.com>
	<1536126475.15675.1.camel@linux.intel.com>
	<20180905141022.GM12698@habkost.net>
	<7273e550-8735-7524-f499-2e0710ed0619@redhat.com>
	<20180905164422.GQ12698@habkost.net>
	<5d62b4c9-5268-ce3a-6e59-9e39011c2b74@redhat.com>
	<9E79D1C9A97CFD4097BCE431828FDD3115FFAADC@SHSMSX103.ccr.corp.intel.com>
	<20180910173817.GC12698@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] Change other funcitons referring to
 feature_word_info[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu, Jingqi" <jingqi.liu@intel.com>, Markus Armbruster <armbru@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On Mon, 2018-09-10 at 14:38 -0300, Eduardo Habkost wrote:
> On Thu, Sep 06, 2018 at 06:00:29AM +0000, Hu, Robert wrote:
> > 
> > > 
> > > Yeah, since this type is used in the qom-get backdoor that evades
> > > introspection,
> > > it's even more important that you follow the backwards-
> > > compatibility rules and
> > > not rename or delete any previously-mandatory members, since
> > > libvirt CAN'T
> > > introspect if such changes have happened.
> > > 
> > 
> > [Robert Hoo] 
> > Oh, this is more complicated than my thought.
> > So, Eduardo, how about leave the QAPI expansion for MSR based
> > features to other
> > professional people?
> 
> I think it's now clear that we can't add MSR features to
> "feature-words" in a compatible way, so any mechanism to
> introspect MSR features will need a separate property or QMP
> command.
> 
> I also think "feature-words" needs to be replaced with something
> better.  Probably libvirt should be able to grab all information
> it needs by looking at the boolean QOM properties instead of the
> low-level info at "feature-words".
> 
> This means I agree to leave this functionality out of the MSR
> feature patch series for now.

Thanks Eduardo. Clear to me now.
> 
