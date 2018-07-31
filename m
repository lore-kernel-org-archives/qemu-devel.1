Received: from eggs.gnu.org ([2001:4830:134:3::10]:48063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkTZo-00008w-Az
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkTZk-00082G-Bj
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:16:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fkTZk-00081r-54
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:16:28 -0400
References: <CAB3eZfuTdzecv2ParQmbiO6sjrUJ7tpV0HEo_2=2cYC890mOCg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac7d377c-db69-c4ee-3d90-94700259db56@redhat.com>
Date: Tue, 31 Jul 2018 07:16:26 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfuTdzecv2ParQmbiO6sjrUJ7tpV0HEo_2=2cYC890mOCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Any tutorial to read/write in qcow2 format by
 programming way?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

On 07/31/2018 04:44 AM, lampahome wrote:
> As titled
> 
> I learn some info about qcow2 and tried to write some data and make it
> qualified for qcow2 format.
> 
> I do it and mount through qemu-nbd successfully.
> 
> But I don't know how taking snapshot and backing file works in programming
> way.
> 
> Can someone tell me some tutorial to know or code snippets to learn?

No real tutorial other than reading the code and the file format 
specification (it's open source, after all).  See:
block/qcow2*
docs/interop/qcow2.txt

Other potential resources to study:

https://github.com/jnsnow/qcheck.git

implements a rudimentary qcow2 image checker, although it still does not 
handle incremental snapshots. Then again, if you want to learn the qcow2 
image format, enhancing that tool would be a great asset in your quest.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
