Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C23C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECC52067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7oNfIrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECC52067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipLWb-0004z0-3d
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 19:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1ipLVn-0004Ta-7l
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1ipLVl-00081S-Lx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:17:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ipLVl-00080M-H6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578529036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KbfDXpJBT56FymVO+6Vafp0rSmE6NDV7ReLU4b5KNTk=;
 b=K7oNfIrscgv+z0q+D53K4N88ISfLfUT9Nn6ElPg1n6zMXCvGzXLVh/nYE3ITvA+0Hn1Aya
 4LD0kUm7l9Bsy/QGVZkIZUshHPNpqQExvArKS9HZaZm5t9r4eNHpk4qIWrnjm2+2yQUgUs
 MUgz43UJ7TjjGGx+V5E2UG3q/np8xTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-PVdynZtYNCe3NytzN2relA-1; Wed, 08 Jan 2020 19:17:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43BB7477
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 00:17:14 +0000 (UTC)
Received: from [10.18.17.134] (dhcp-17-134.bos.redhat.com [10.18.17.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B7801A8E2;
 Thu,  9 Jan 2020 00:17:11 +0000 (UTC)
Subject: Re: [PATCH 2/5] python/qemu: Delint the qmp module
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191227134101.244496-1-wainersm@redhat.com>
 <20191227134101.244496-3-wainersm@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <415f6e37-5d57-1a00-ef9f-80472b85e0c6@redhat.com>
Date: Wed, 8 Jan 2020 19:17:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191227134101.244496-3-wainersm@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PVdynZtYNCe3NytzN2relA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/27/19 8:40 AM, Wainer dos Santos Moschetta wrote:
> This clean up the pylint-3 report on qmp:
>=20
> ************* Module qemu.qmp
> python/qemu/qmp.py:1:0: C0111: Missing module docstring (missing-docstrin=
g)
> python/qemu/qmp.py:17:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:21:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:25:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:29:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:33:0: C0111: Missing class docstring (missing-docstrin=
g)
> python/qemu/qmp.py:33:0: R0205: Class 'QEMUMonitorProtocol' inherits from=
 object, can be safely removed from bases in python3 (useless-object-inheri=
tance)
> python/qemu/qmp.py:80:4: R1710: Either all return statements in a functio=
n should return an expression, or none of them should. (inconsistent-return=
-statements)
> python/qemu/qmp.py:131:4: R1710: Either all return statements in a functi=
on should return an expression, or none of them should. (inconsistent-retur=
n-statements)
> python/qemu/qmp.py:159:4: R1710: Either all return statements in a functi=
on should return an expression, or none of them should. (inconsistent-retur=
n-statements)
> python/qemu/qmp.py:245:4: C0111: Missing method docstring (missing-docstr=
ing)
> python/qemu/qmp.py:249:4: C0111: Missing method docstring (missing-docstr=
ing)
> python/qemu/qmp.py:252:4: C0111: Missing method docstring (missing-docstr=
ing)
> python/qemu/qmp.py:255:4: C0111: Missing method docstring (missing-docstr=
ing)
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

ACK, thanks for the delinting work here. It will be nice to get our
python code in such a shape that it *could* be packaged if we want to.

Like, if we wanted to publish a standalone QMP client, for instance...

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  python/qemu/qmp.py | 51 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 10 deletions(-)
>=20
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index 8c6c9847d0..f4e04a6683 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -1,5 +1,4 @@
> -# QEMU Monitor Protocol Python class
> -#
> +""" QEMU Monitor Protocol Python class """
>  # Copyright (C) 2009, 2010 Red Hat Inc.
>  #
>  # Authors:
> @@ -15,22 +14,34 @@ import logging
> =20
> =20
>  class QMPError(Exception):
> -    pass
> +    """
> +    QMP base exception
> +    """
> =20
> =20
>  class QMPConnectError(QMPError):
> -    pass
> +    """
> +    QMP connection exception
> +    """
> =20
> =20
>  class QMPCapabilitiesError(QMPError):
> -    pass
> +    """
> +    QMP negotiate capabilities exception
> +    """
> =20
> =20
>  class QMPTimeoutError(QMPError):
> -    pass
> +    """
> +    QMP timeout exception
> +    """
> =20
> =20
> -class QEMUMonitorProtocol(object):
> +class QEMUMonitorProtocol:
> +    """
> +    Provide an API to connect to QEMU via QEMU Monitor Protocol (QMP) an=
d then
> +    allow to handle commands and events.
> +    """
> =20
>      #: Logger object for debugging messages
>      logger =3D logging.getLogger('QMP')
> @@ -81,7 +92,7 @@ class QEMUMonitorProtocol(object):
>          while True:
>              data =3D self.__sockfile.readline()
>              if not data:
> -                return
> +                return None
>              resp =3D json.loads(data)
>              if 'event' in resp:
>                  self.logger.debug("<<< %s", resp)
> @@ -132,7 +143,7 @@ class QEMUMonitorProtocol(object):
>          """
>          Connect to the QMP Monitor and perform capabilities negotiation.
> =20
> -        @return QMP greeting dict
> +        @return QMP greeting dict, or None if negotiate is false
>          @raise OSError on socket connection errors
>          @raise QMPConnectError if the greeting is not received
>          @raise QMPCapabilitiesError if fails to negotiate capabilities
> @@ -141,6 +152,7 @@ class QEMUMonitorProtocol(object):
>          self.__sockfile =3D self.__sock.makefile()
>          if negotiate:
>              return self.__negotiate_capabilities()
> +        return None
> =20
>      def accept(self):
>          """
> @@ -169,7 +181,7 @@ class QEMUMonitorProtocol(object):
>              self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
>          except OSError as err:
>              if err.errno =3D=3D errno.EPIPE:
> -                return
> +                return None
>              raise err
>          resp =3D self.__json_read()
>          self.logger.debug("<<< %s", resp)
> @@ -243,14 +255,33 @@ class QEMUMonitorProtocol(object):
>          self.__events =3D []
> =20
>      def close(self):
> +        """
> +        Close the socket and socket file.
> +        """
>          self.__sock.close()
>          self.__sockfile.close()
> =20
>      def settimeout(self, timeout):
> +        """
> +        Set the socket timeout.
> +
> +        @param timeout (float): timeout in seconds, or None.
> +        @note This is a wrap around socket.settimeout
> +        """
>          self.__sock.settimeout(timeout)
> =20
>      def get_sock_fd(self):
> +        """
> +        Get the socket file descriptor.
> +
> +        @return The file descriptor number.
> +        """
>          return self.__sock.fileno()
> =20
>      def is_scm_available(self):
> +        """
> +        Check if the socket allows for SCM_RIGHTS.
> +
> +        @return True if SCM_RIGHTS is available, otherwise False.
> +        """
>          return self.__sock.family =3D=3D socket.AF_UNIX
>=20

--=20
=E2=80=94js


