Received: from eggs.gnu.org ([2001:4830:134:3::10]:56389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHX0F-0008On-BU
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHX0B-0000Uq-5k
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:36:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHX08-0000MI-5L
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC852308A94C
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 16:36:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181023213600.364086-1-eblake@redhat.com>
Date: Tue, 30 Oct 2018 17:36:11 +0100
In-Reply-To: <20181023213600.364086-1-eblake@redhat.com> (Eric Blake's message
	of "Tue, 23 Oct 2018 22:35:59 +0100")
Message-ID: <87o9bbfl38.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] vl: Avoid crash when -mon is underspecified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> A quick coredump on an incomplete command line:
> ./x86_64-softmmu/qemu-system-x86_64 -mon mode=control,pretty=on
>
>  #0  0x00007ffff723d9e4 in g_str_hash () at /lib64/libglib-2.0.so.0
>  #1  0x00007ffff723ce38 in g_hash_table_lookup () at /lib64/libglib-2.0.so.0
>  #2  0x0000555555cc0073 in object_class_property_find (klass=0x5555566a94b0, name=0x0, errp=0x0) at qom/object.c:1135
>  #3  0x0000555555cc004b in object_class_property_find (klass=0x5555566a9440, name=0x0, errp=0x0) at qom/object.c:1129
>  #4  0x0000555555cbfe6e in object_property_find (obj=0x5555568348c0, name=0x0, errp=0x0) at qom/object.c:1080
>  #5  0x0000555555cc183d in object_resolve_path_component (parent=0x5555568348c0, part=0x0) at qom/object.c:1762
>  #6  0x0000555555d82071 in qemu_chr_find (name=0x0) at chardev/char.c:802
>  #7  0x00005555559d77cb in mon_init_func (opaque=0x0, opts=0x5555566b65a0, errp=0x0) at vl.c:2291
>
> Fix it to instead fail gracefully.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Queued.  Thanks!
