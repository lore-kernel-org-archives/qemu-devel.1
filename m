Received: from eggs.gnu.org ([2001:4830:134:3::10]:49874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dorTT-00048m-4K
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dorSf-00032s-0Z
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:31:35 -0400
Date: Mon, 4 Sep 2017 15:28:59 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170904132859.cqj4ufphrvz2wsys@eukaryote>
References: <20170904111616.21333-1-kchamart@redhat.com>
	<20170904125523.GC19748@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170904125523.GC19748@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Make test 192 use QMP;
 convert it to Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, eblake@redhat.com, kwolf@redhat.com, dgilbert@redhat.com

On Mon, Sep 04, 2017 at 08:55:23PM +0800, Fam Zheng wrote:
> Hi Kashyap,
> 
> On Mon, 09/04 13:16, Kashyap Chamarthy wrote:

[...]

> > +dest_vm = (iotests.VM('dest').add_drive(test_img_path)
> > +                               .add_incoming('defer'))
> 
> Superfluous parenthesis?

Yes, the paranthesis can be removed and turn it into a single line:
    
  dest_vm = iotests.VM('dest').add_drive(test_img_path).add_incoming('defer')

> > +dest_vm.launch()
> > +atexit.register(dest_vm.shutdown)
> 
> As an improvement maybe you could rebase to Stefan's "iotests: clean up
> resources using context managers" series and switch to "with" for the temp file
> and VM.

Good point.  I did notice that thread[*] about resource clean up.  And I
see it's already applied to 'block-next'.  Will rebase and change to the
'with' statement.

[*] https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04639.html

> Otherwise looks good to me.

Thanks for the quick review!

[...]

-- 
/kashyap
