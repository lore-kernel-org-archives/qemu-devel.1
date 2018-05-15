Received: from eggs.gnu.org ([2001:4830:134:3::10]:57259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIWao-0007Ei-2U
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIWaj-0008IN-8M
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:50:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37258 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fIWaj-0008I9-3h
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:49:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C4F04021BA0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 09:49:56 +0000 (UTC)
Date: Tue, 15 May 2018 11:49:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180515094955.o5rwu5wpaawmszcb@sirius.home.kraxel.org>
References: <20180509152608.9343-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509152608.9343-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH v2] docs/interop: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: libvirt devel <libvir-list@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On Wed, May 09, 2018 at 05:26:08PM +0200, Laszlo Ersek wrote:
> Add a schema that describes the different uses and properties of virtual
> machine firmware.
> 
> Each firmware executable installed on a host system should come with at
> least one JSON file that conforms to this schema. Each file informs the
> management applications about
> - the firmware's properties and one possible use case / feature set,
> - configuration bits that are required to run the firmware binary.
> 
> In addition, define rules for management apps for picking the highest
> priority firmware JSON file when multiple such files match the search
> criteria.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
