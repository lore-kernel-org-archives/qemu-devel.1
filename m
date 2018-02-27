Received: from eggs.gnu.org ([2001:4830:134:3::10]:50032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlsn-0006ST-3m
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlsj-00062d-Qa
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:29:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqlsj-00062Q-L6
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:29:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13AB98D6BE
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 20:29:38 +0000 (UTC)
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<20180227173639.7aeea5ce@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa13da76-d077-556f-4f1e-6d45e2256eab@redhat.com>
Date: Tue, 27 Feb 2018 14:29:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180227173639.7aeea5ce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/9] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On 02/27/2018 10:36 AM, Igor Mammedov wrote:
> On Fri, 16 Feb 2018 13:37:12 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> Eric,
> 
> Adding you to CC list (git send-mail somehow haven't noticed you in cover letter).

Actually, I did get CC'd on the original cover letter, but you are 
reading the copy that hit the list, which means we are suffering from 
mailman's bug that it rewrites emails sent through the list to drop cc 
of readers that requested no duplicates (I really detest that mailman 2 
corrupts cc's as a side effect of what is otherwise a potentially useful 
knob, and can only hope that mailman 3 has split its behavior into two 
separate knobs).

> 
> Could you please look at QAPI/QMP parts of this series.

Yes, starting a read-through now.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
