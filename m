Received: from eggs.gnu.org ([209.51.188.92]:37216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpFn-0000nt-6o
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpFj-0005eM-A1
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:11:03 -0500
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023078871.1011724.3083923389814185598.stgit@bahia.lan>
	<20190217231455.GB2765@umbus.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03af3e28-3fdb-50e9-295a-09dededf5af5@redhat.com>
Date: Mon, 18 Feb 2019 14:10:41 -0600
MIME-Version: 1.0
In-Reply-To: <20190217231455.GB2765@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] xics: Explicitely call KVM ICP
 methods from the common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org

On 2/17/19 5:14 PM, David Gibson wrote:

In the subject line: s/Explicitely/Explicitly/

> On Fri, Feb 15, 2019 at 12:39:48PM +0100, Greg Kurz wrote:
>> The pre_save(), post_load() and synchronize_state() methods of the
>> ICPStateClass type are really KVM only things. Make that obvious
>> by dropping the indirections and directly calling the KVM functions
>> instead.
>>
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
