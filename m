Received: from eggs.gnu.org ([2001:4830:134:3::10]:33579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLszZ-0004yE-7k
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLszU-0008M7-6N
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:21:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fLszU-0008Lr-1w
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:21:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76875401EF00
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 16:21:23 +0000 (UTC)
References: <20180509152608.9343-1-lersek@redhat.com>
	<20180515094955.o5rwu5wpaawmszcb@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <de8ac175-64c7-e8f2-905c-92f1f749cd28@redhat.com>
Date: Thu, 24 May 2018 18:21:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180515094955.o5rwu5wpaawmszcb@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH v2] docs/interop: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, libvirt devel <libvir-list@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

On 05/15/18 11:49, Gerd Hoffmann wrote:
> On Wed, May 09, 2018 at 05:26:08PM +0200, Laszlo Ersek wrote:
>> Add a schema that describes the different uses and properties of virtual
>> machine firmware.
>>
>> Each firmware executable installed on a host system should come with at
>> least one JSON file that conforms to this schema. Each file informs the
>> management applications about
>> - the firmware's properties and one possible use case / feature set,
>> - configuration bits that are required to run the firmware binary.
>>
>> In addition, define rules for management apps for picking the highest
>> priority firmware JSON file when multiple such files match the search
>> criteria.
> 
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks, Gerd!

Does anyone else intend to comment? Or should I ask for someone to queue
the patch for a pull request?

Thanks!
Laszlo
