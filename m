Received: from eggs.gnu.org ([2001:4830:134:3::10]:50908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsU3V-0000UR-DK
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsU3R-00053Q-Ef
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:24:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42774 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsU3R-00052t-9l
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:24:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DECD87A6D
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 14:24:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <f95390a5-2b4b-e364-34b4-15ff62c2c580@redhat.com> (Thomas Huth's
	message of "Wed, 22 Aug 2018 12:08:07 +0200")
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-2-quintela@redhat.com>
	<f95390a5-2b4b-e364-34b4-15ff62c2c580@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 16:24:00 +0200
Message-ID: <87k1oipji7.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 01/10] configure: We don't want to clean
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 2018-08-22 11:54, Juan Quintela wrote:
>> If you don't want to compile everything, you configure
>> config-devices.mak.  And then make clean remove it, and make will
>> create a default one without your configuration.  Fix it by not
>> removing it on clean target.  Remove it instead on distclean.
>
> Sounds like a good idea!
>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> --
>> 
>> Remove it instead on distclean.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Please remove the duplicated Sob. Then you can add:

Done, thanks.

> Reviewed-by: Thomas Huth <thuth@redhat.com>
