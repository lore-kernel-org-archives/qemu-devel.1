Received: from eggs.gnu.org ([2001:4830:134:3::10]:56982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOSuq-0006wa-5o
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOSum-0005Z4-6p
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:07:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOSum-0005TV-2Y
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:07:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33E2E406F619
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 19:07:04 +0000 (UTC)
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
	<20180531171606.21604-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08772d2d-436f-2388-0eb0-09b4479e9a47@redhat.com>
Date: Thu, 31 May 2018 14:07:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180531171606.21604-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 40/53] docs/interop: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, David Gibson <dgibson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>

On 05/31/2018 12:15 PM, Paolo Bonzini wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
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
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Message-Id: <20180509152608.9343-1-lersek@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Not Laszlo's fault, and not the only such patch that needs it, but

> ---
>   docs/interop/firmware.json | 540 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 540 insertions(+)
>   create mode 100644 docs/interop/firmware.json
> 
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json

> +#
> +# Since: 2.13

s/2.13/3.0/g in the interface files to match Peter's recent commits.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
