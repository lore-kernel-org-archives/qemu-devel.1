Received: from eggs.gnu.org ([2001:4830:134:3::10]:60402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVBX4-00040J-Ew
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVBX2-0005KO-HN
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVBX2-0005Je-Ak
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:53:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14C7D267C0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 06:53:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170711154414.21111-1-dgilbert@redhat.com>
Date: Wed, 12 Jul 2017 08:53:49 +0200
In-Reply-To: <20170711154414.21111-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Tue, 11 Jul 2017 16:44:14 +0100")
Message-ID: <8737a2cfia.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] hmp: Update info vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, marcandre.lureau@redhat.com, lcapitulino@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The QMP query-vnc interfaces have gained a lot more information that
> the HMP interfaces hasn't got yet. Update it.
>
> Note the output format has changed, but this is HMP so that's OK.
>
> In particular, this now includes client information for reverse
> connections:
>
> -vnc :0
> (qemu) info vnc
> default:
>   Server: 0.0.0.0:5900 (ipv4)
>     Auth: none (Sub: none)
>
>   (Now connect a client)
>
> (qemu) info vnc
> default:
>   Server: 0.0.0.0:5900 (ipv4)
>     Auth: none (Sub: none)
>   Client: 127.0.0.1:51828 (ipv4)
>     x509_dname: none
>     sasl_username: none
>
> -vnc localhost:7000,reverse
> (qemu) info vnc
> default:
>   Client: ::1:7000 (ipv6)
>     x509_dname: none
>     sasl_username: none
>   Auth: none (Sub: none)
>
> -vnc :1,password,id=pass -vnc localhost:7000,reverse
> (qemu) info vnc
> default:
>   Client: ::1:7000 (ipv6)
>     x509_dname: none
>     sasl_username: none
>   Auth: none (Sub: none)
> rev:
>   Server: 0.0.0.0:5901 (ipv4)
>     Auth: vnc (Sub: none)
>   Client: 127.0.0.1:53616 (ipv4)
>     x509_dname: none
>     sasl_username: none
>
> This was originally RH bz 1461682
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
