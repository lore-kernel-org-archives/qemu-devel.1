Received: from eggs.gnu.org ([2001:4830:134:3::10]:33983)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1emKT7-0001qY-5t
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1emKT4-0002F8-06
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:25:01 -0500
Received: from mx01.kamp.de ([82.141.2.16]:52023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1emKT3-0002Ei-M7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:24:57 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 15:24:53 +0100
References: <20180215111526.2464-1-stefanha@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <ecc44671-4f09-5c52-57ea-4818b351795d@kamp.de>
Date: Thu, 15 Feb 2018 15:24:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180215111526.2464-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: cancel libiscsi task when
 ABORT TASK TMF completes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Felipe Franciosi <felipe@nutanix.com>

Am 15.02.2018 um 12:15 schrieb Stefan Hajnoczi:
> The libiscsi iscsi_task_mgmt_async() API documentation says:
>
>    abort_task will also cancel the scsi task. The callback for the scsi
>    task will be invoked with SCSI_STATUS_CANCELLED
>
> The libiscsi implementation does not fulfil this promise.  The task's
> callback is not invoked and its struct iscsi_pdu remains in the internal
> list (effectively leaked).

If that contract is fixed in libiscsi, will the Qemu iSCSI driver still work?

Peter
