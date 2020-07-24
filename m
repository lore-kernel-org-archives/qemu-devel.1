Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E79C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6B02067D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bimGZ6bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6B02067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz10F-0003EJ-Dm
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jz0zU-0002Kn-KE
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:56:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jz0zS-0004e0-Q1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595609770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCDyBopF8pI8RBzzq+5YjYHLD/nq8slNluDuF5Shyj8=;
 b=bimGZ6bYU5nKUGVSPCk4SbcKp0dNbZbTbOL/S3Fqx9UDdng27qXbYKEItb5/n0gCFUjWVm
 9EuSMU0xlE45xBr9SbhU+X5UDyIzT0vsANvgzQVBcuHsIHV8moHog2Kd8QeGlnp+xtIzW1
 7ztjTFxGI51qpUHgtCJmBbNP3ry6i3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-46oMcWnAP8W5dFmiAcLi_g-1; Fri, 24 Jul 2020 12:56:08 -0400
X-MC-Unique: 46oMcWnAP8W5dFmiAcLi_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D29619057C6
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 16:56:07 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3D6F76210;
 Fri, 24 Jul 2020 16:56:06 +0000 (UTC)
Subject: Re: [PATCH 2/3] scripts/qmp/qom-fuse: Port to current Python module
 fuse
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200723142738.1868568-1-armbru@redhat.com>
 <20200723142738.1868568-3-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <30a62da5-6091-ee96-7614-c129cb04d350@redhat.com>
Date: Fri, 24 Jul 2020 12:56:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723142738.1868568-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 10:27 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Honestly, benefit of the doubt on this one. The Python looks fine, but I 
don't know much about the FUSE module. Still, it was broken before, so 
if you claim it now works for you, that's more useful than it used to be.

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>   scripts/qmp/qom-fuse | 93 ++++++++++++++++++++++----------------------
>   1 file changed, 47 insertions(+), 46 deletions(-)
> 
> diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
> index b7dabe8d65..405e6ebd67 100755
> --- a/scripts/qmp/qom-fuse
> +++ b/scripts/qmp/qom-fuse
> @@ -3,16 +3,18 @@
>   # QEMU Object Model test tools
>   #
>   # Copyright IBM, Corp. 2012
> +# Copyright (C) 2020 Red Hat, Inc.
>   #
>   # Authors:
>   #  Anthony Liguori   <aliguori@us.ibm.com>
> +#  Markus Armbruster <armbru@redhat.com>
>   #
>   # This work is licensed under the terms of the GNU GPL, version 2 or later.  See
>   # the COPYING file in the top-level directory.
>   ##
>   
>   import fuse, stat
> -from fuse import Fuse
> +from fuse import FUSE, FuseOSError, Operations
>   import os, posix, sys
>   from errno import *
>   
> @@ -21,9 +23,8 @@ from qemu.qmp import QEMUMonitorProtocol
>   
>   fuse.fuse_python_api = (0, 2)
>   
> -class QOMFS(Fuse):
> -    def __init__(self, qmp, *args, **kwds):
> -        Fuse.__init__(self, *args, **kwds)
> +class QOMFS(Operations):
> +    def __init__(self, qmp):
>           self.qmp = qmp
>           self.qmp.connect()
>           self.ino_map = {}
> @@ -65,21 +66,21 @@ class QOMFS(Fuse):
>           except:
>               return False
>   
> -    def read(self, path, length, offset):
> +    def read(self, path, length, offset, fh):
>           if not self.is_property(path):
>               return -ENOENT
>   
>           path, prop = path.rsplit('/', 1)
>           try:
> -            data = str(self.qmp.command('qom-get', path=path, property=prop))
> +            data = self.qmp.command('qom-get', path=path, property=prop)
>               data += '\n' # make values shell friendly
>           except:
> -            return -EPERM
> +            raise FuseOSError(EPERM)
>   
>           if offset > len(data):
>               return ''
>   
> -        return str(data[offset:][:length])
> +        return bytes(data[offset:][:length], encoding='utf-8')
>   
>       def readlink(self, path):
>           if not self.is_link(path):
> @@ -89,52 +90,52 @@ class QOMFS(Fuse):
>           return prefix + str(self.qmp.command('qom-get', path=path,
>                                                property=prop))
>   
> -    def getattr(self, path):
> +    def getattr(self, path, fh=None):
>           if self.is_link(path):
> -            value = posix.stat_result((0o755 | stat.S_IFLNK,
> -                                       self.get_ino(path),
> -                                       0,
> -                                       2,
> -                                       1000,
> -                                       1000,
> -                                       4096,
> -                                       0,
> -                                       0,
> -                                       0))
> +            value = { 'st_mode': 0o755 | stat.S_IFLNK,
> +                      'st_ino': self.get_ino(path),
> +                      'st_dev': 0,
> +                      'st_nlink': 2,
> +                      'st_uid': 1000,
> +                      'st_gid': 1000,
> +                      'st_size': 4096,
> +                      'st_atime': 0,
> +                      'st_mtime': 0,
> +                      'st_ctime': 0 }
>           elif self.is_object(path):
> -            value = posix.stat_result((0o755 | stat.S_IFDIR,
> -                                       self.get_ino(path),
> -                                       0,
> -                                       2,
> -                                       1000,
> -                                       1000,
> -                                       4096,
> -                                       0,
> -                                       0,
> -                                       0))
> +            value = { 'st_mode': 0o755 | stat.S_IFDIR,
> +                      'st_ino': self.get_ino(path),
> +                      'st_dev': 0,
> +                      'st_nlink': 2,
> +                      'st_uid': 1000,
> +                      'st_gid': 1000,
> +                      'st_size': 4096,
> +                      'st_atime': 0,
> +                      'st_mtime': 0,
> +                      'st_ctime': 0 }
>           elif self.is_property(path):
> -            value = posix.stat_result((0o644 | stat.S_IFREG,
> -                                       self.get_ino(path),
> -                                       0,
> -                                       1,
> -                                       1000,
> -                                       1000,
> -                                       4096,
> -                                       0,
> -                                       0,
> -                                       0))
> +            value = { 'st_mode': 0o644 | stat.S_IFREG,
> +                      'st_ino': self.get_ino(path),
> +                      'st_dev': 0,
> +                      'st_nlink': 1,
> +                      'st_uid': 1000,
> +                      'st_gid': 1000,
> +                      'st_size': 4096,
> +                      'st_atime': 0,
> +                      'st_mtime': 0,
> +                      'st_ctime': 0 }
>           else:
> -            value = -ENOENT
> +            raise FuseOSError(ENOENT)
>           return value
>   
> -    def readdir(self, path, offset):
> -        yield fuse.Direntry('.')
> -        yield fuse.Direntry('..')
> +    def readdir(self, path, fh):
> +        yield '.'
> +        yield '..'
>           for item in self.qmp.command('qom-list', path=path):
> -            yield fuse.Direntry(str(item['name']))
> +            yield str(item['name'])
>   
>   if __name__ == '__main__':
>       import os
>   
> -    fs = QOMFS(QEMUMonitorProtocol(os.environ['QMP_SOCKET']))
> -    fs.main(sys.argv)
> +    fuse = FUSE(QOMFS(QEMUMonitorProtocol(os.environ['QMP_SOCKET'])),
> +                sys.argv[1], foreground=True)
> 


