Received: from eggs.gnu.org ([2001:4830:134:3::10]:33221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fGQrq-0008Tq-00
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fGQrl-0001lD-4I
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:18:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fGQrk-0001k4-VJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:18:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E54B401CC41
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 15:18:52 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
References: <20180509150431.4979-1-lersek@redhat.com>
Message-ID: <682d4d57-35d2-6eb0-766c-cba4819ef05a@redhat.com>
Date: Wed, 9 May 2018 17:18:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180509150431.4979-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH] docs/interop: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libvirt devel <libvir-list@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

On 05/09/18 17:04, Laszlo Ersek wrote:
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
> 
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: David Gibson <dgibson@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
> 
> Notes:
>     PATCH:
>     
>     - previous version (RFCv3) was posted at:
>       <http://mid.mail-archive.com/20180420231246.23130-4-lersek@redhat.com>
>     
>     - move "firmware.json" under docs/interop/; drop earlier development
>       artifacts
>     
>     - no changes to the schema (received no comments on RFCv3)

oops:

> +##
> +# @x-check-firmware:
> +#
> +# Accept a @Firmware object and do nothing, successfully. This command
> +# can be used in the QMP shell to validate @Firmware JSON against the
> +# schema.
> +#
> +# @fw: ignored
> +#
> +# Since: 2.13
> +##
> +{ 'command' : 'x-check-firmware',
> +  'data'    : { 'fw' : 'Firmware' } }
> 

missed this part (I should have removed it), I will post v2 soon.

Laszlo
