Received: from eggs.gnu.org ([2001:4830:134:3::10]:34082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLt1W-0006ZX-DX
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLt1R-0000yN-C3
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:23:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLt1R-0000yD-6C
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:23:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C79154022407
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 16:23:24 +0000 (UTC)
References: <20180509152608.9343-1-lersek@redhat.com>
	<20180515094955.o5rwu5wpaawmszcb@sirius.home.kraxel.org>
	<de8ac175-64c7-e8f2-905c-92f1f749cd28@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1835b91a-57ab-eb7e-dd98-68421c19a425@redhat.com>
Date: Thu, 24 May 2018 18:23:14 +0200
MIME-Version: 1.0
In-Reply-To: <de8ac175-64c7-e8f2-905c-92f1f749cd28@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, libvirt devel <libvir-list@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, David Gibson <dgibson@redhat.com>

On 24/05/2018 18:21, Laszlo Ersek wrote:
> On 05/15/18 11:49, Gerd Hoffmann wrote:
>> On Wed, May 09, 2018 at 05:26:08PM +0200, Laszlo Ersek wrote:
>>> Add a schema that describes the different uses and properties of virtual
>>> machine firmware.
>>>
>>> Each firmware executable installed on a host system should come with at
>>> least one JSON file that conforms to this schema. Each file informs the
>>> management applications about
>>> - the firmware's properties and one possible use case / feature set,
>>> - configuration bits that are required to run the firmware binary.
>>>
>>> In addition, define rules for management apps for picking the highest
>>> priority firmware JSON file when multiple such files match the search
>>> criteria.
>>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Thanks, Gerd!
> 
> Does anyone else intend to comment? Or should I ask for someone to queue
> the patch for a pull request?

Since no one has done that so far I've queued it, thanks!

Paolo
