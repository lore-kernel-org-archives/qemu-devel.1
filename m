Received: from eggs.gnu.org ([208.118.235.92]:45619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gcsqD-0005Wu-Pd
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gcsdA-0002rz-4j
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 08:56:52 -0500
References: <320758d6-012b-0b17-2467-f73bf8f4dcb2@virtuozzo.com>
	<CAMRbyytAWPgKJFLfSjq4FD-G0dsTB4mJC8sspMx3ApMJ8rGdVw@mail.gmail.com>
	<359b482e-8be6-49b4-e2de-c2498af10127@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c3b9c7e-5926-24a4-59a5-3fcf06319f50@redhat.com>
Date: Fri, 28 Dec 2018 14:56:34 +0100
MIME-Version: 1.0
In-Reply-To: <359b482e-8be6-49b4-e2de-c2498af10127@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] do not lseek in qcow2 block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 25/12/18 10:45, Vladimir Sementsov-Ogievskiy wrote:
>>
>>     What are the cases, when we really need digging for zeros in bs->file?

It's needed for preallocation=metadata.

Paolo
