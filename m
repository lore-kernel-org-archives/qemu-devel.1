Received: from eggs.gnu.org ([2001:4830:134:3::10]:38890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8URD-00013G-Qd
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8URD-0000VM-3z
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:55 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-4-crosa@redhat.com>
	<4ebd6e33-e1e7-962f-3ca8-4bae7b7ce425@redhat.com>
	<c33abf23-46c6-3939-f781-61662714acc5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b62d615-615b-a128-9c22-7d37df052abb@redhat.com>
Date: Fri, 5 Oct 2018 13:02:43 -0500
MIME-Version: 1.0
In-Reply-To: <c33abf23-46c6-3939-f781-61662714acc5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] qemu-iotests: make 218 executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 10/5/18 12:49 PM, Cleber Rosa wrote:

>>
>> We could add a git pre-commit hook grep'ing for "^#!\
>> *(/usr/bin/env|/bin/(b?a)?sh)" in the 1st line and then checking the
>> file perms.
>>
> 
> Good idea.  Probably better to send that as a different patch, right?

Yes, separate patch. For that matter, "^#!/" is probably a sufficient 
pattern to catch any file that intends to be run via an interpreter, and 
therefore wants to be executable, rather than limiting to just env and 
specific shells.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
