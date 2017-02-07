Received: from eggs.gnu.org ([2001:4830:134:3::10]:58605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cb27U-0004OJ-Ll
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cb27P-00081p-O1
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:31:28 -0500
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:44514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cb27P-00080x-Hg
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:31:23 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 39A59A8439
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 10:31:20 +0100 (CET)
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-3-git-send-email-fred.konrad@greensocs.com>
	<6b974238-ab18-8bd5-ffe7-6f07627f59f3@kaod.org>
	<5850976f-7e05-dbcf-3fdf-cf9d11038b3d@greensocs.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <682b8d3a-bf00-012e-a79e-434358d181bb@kaod.org>
Date: Tue, 7 Feb 2017 10:31:11 +0100
MIME-Version: 1.0
In-Reply-To: <5850976f-7e05-dbcf-3fdf-cf9d11038b3d@greensocs.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 02/10] qemu-clk: allow to add a clock to
 a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frederic Konrad <fred.konrad@greensocs.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com

On 02/07/2017 10:22 AM, Frederic Konrad wrote:
>> I see how these routines are used in patch 10/10. But if we were
>> open coding device CRF_APB, I don't think we would need them at
>> all and it would make the code a little simple IMHO.
> What do you mean by open coding?

I mean to externalize the definition of the objects in a 
header file. 

Then you can replace the type 'Object *' of the attribute 
holding a reference to an instance by a non pointer type.

Anyhow, I think we need to replace object_new() by 
object_initialize() for QOM, and so we need to expose a 
little more the object internals. 

Thanks,

C.
