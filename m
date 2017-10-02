Received: from eggs.gnu.org ([2001:4830:134:3::10]:43744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dywRO-0007NG-1j
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dywRL-0003gb-2j
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dywRK-0003ez-SS
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAAD185550
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 08:51:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170927204148.2311-1-ehabkost@redhat.com>
	<20170927204148.2311-2-ehabkost@redhat.com>
Date: Mon, 02 Oct 2017 10:51:00 +0200
In-Reply-To: <20170927204148.2311-2-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 27 Sep 2017 17:41:47 -0300")
Message-ID: <87tvzioruz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/2] config: qemu_config_parse() return
 number of config groups
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Change qemu_config_parse() to return the number of config groups
> in success and -EINVAL on error. This will allow callers of
> qemu_config_parse() to check if something was really loaded from
> the config file.
>
> All existing callers of qemu_config_parse() and
> qemu_read_config_file() only check if the return value was
> negative, so the change shouldn't affect them.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
