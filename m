Received: from eggs.gnu.org ([2001:4830:134:3::10]:36400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eql8H-0000Ux-Jj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eql8G-0000xT-Th
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:41:49 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-11-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ff29beb-18a4-52e3-17b2-326081d6e9c5@redhat.com>
Date: Tue, 27 Feb 2018 13:41:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-11-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 10/21] blockjobs: add NULL state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> Add a new state that specifically demarcates when we begin to permanently
> demolish a job after it has performed all work. This makes the transition
> explicit in the STM table and highlights conditions under which a job may
> be demolished.
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
