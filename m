Received: from eggs.gnu.org ([2001:4830:134:3::10]:48773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5fg-00028O-DV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5fc-00051t-CH
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:18:20 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cW5fc-00051f-6q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:18:16 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so36512987wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:18:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1484633936-25344-5-git-send-email-caoj.fnst@cn.fujitsu.com>
	<587DBEBE.4070409@cn.fujitsu.com>
	<20170117175708-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afeb5d3c-9301-0965-6032-3d44d0a656cc@redhat.com>
Date: Tue, 24 Jan 2017 19:18:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170117175708-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 04/11] msix: check msix_init's return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: jiri@resnulli.us, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, dmitry@daynix.com



On 17/01/2017 17:01, Michael S. Tsirkin wrote:
>>> Doesn't do it for megasas & hcd-xhci, later patches will fix them.
>>>
>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> I don't like this one, frankly. That's a bunch of code duplication.
> I suspect vfio is the only one who might reasonably get EINVAL here.
> So how about e.g. msix_validate_and_init that doesn't assert and use that
> from vfio, then switch msix_init to assert instead?

The names we use normally would be msix_init and msix_init_nofail.
Would still require a change through the whole tree, but it's more
consistent at least.

Paolo
