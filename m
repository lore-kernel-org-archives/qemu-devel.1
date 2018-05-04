Received: from eggs.gnu.org ([2001:4830:134:3::10]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEfMP-0005oQ-EG
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEfML-00054O-GD
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:23:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEfML-00053s-Bx
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:23:09 -0400
References: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f37a588e-681b-72cb-dc55-397d697e9f84@redhat.com>
Date: Fri, 4 May 2018 13:23:07 -0500
MIME-Version: 1.0
In-Reply-To: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] monitor: report entirety of hmp command on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org

On 05/04/2018 09:49 AM, Collin Walling wrote:
> When a user incorrectly provides an hmp command, an error response will be
> printed that prompts the user to try "help <command name>". However, when
> the command contains multiple parts e.g. "info skeys", only the last
> whitespace delimited string will be reported (in this example "info" will
> be dropped and the message will read "Try "help skeys" for more information",
> which is incorrect).
> 
> Let's correct this by capturing the full name of the command as we recurse
> through the function monitor_parse_command.
> 
> Reported-by: Mikhail Fokin <fokin@de.ibm.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Side note:

git shortlog --author=Collin

lists two different spellings for your name based on your previous 
contributions.  You may want to propose a patch to .mailmap to settle on 
the variant that you prefer, so that people grabbing statistics from git 
don't get as confused.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
