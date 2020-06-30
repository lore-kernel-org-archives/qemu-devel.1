Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C821AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F6D20780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0gDTy1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F6D20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDK9-0007rT-Su
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqDIf-0006Re-OW
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:15:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqDId-0006kV-3Z
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593512134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vb7ygvRPmN2ygKpfVgGaW2RA5jYgFDz5aKuaFqPb4KE=;
 b=a0gDTy1lm1z2nClfh99GSQPO0EKxRZxcybuJuj+l+Y3HB3VgOWBQqVWSfI0U4td8QcXu+x
 QYSakpId5jQEL1BVNaqirCIvdD2eFAxu6ruOX8IItQHmQo6Ax0vzbIQD49dVRjhHlLWfso
 EJVE3BQIwM/zqru4myvbXUQslRhOjjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-GNd4VPA0NWuH1jzlPqmYFQ-1; Tue, 30 Jun 2020 06:15:30 -0400
X-MC-Unique: GNd4VPA0NWuH1jzlPqmYFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7A0BEC1A9;
 Tue, 30 Jun 2020 10:15:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09FE061981;
 Tue, 30 Jun 2020 10:15:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 702F811384A6; Tue, 30 Jun 2020 12:15:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 5/5] hw/i2c: Document the I2C qdev helpers
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-6-f4bug@amsat.org>
Date: Tue, 30 Jun 2020 12:15:21 +0200
In-Reply-To: <20200629173821.22037-6-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 29 Jun 2020 19:38:21
 +0200")
Message-ID: <87zh8kg8qu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> In commit d88c42ff2c we added new prototype but neglected to
> add their documentation. Fix that.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/i2c/i2c.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index c533058998..fcc61e509b 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -79,8 +79,56 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool sen=
d);
>  int i2c_send(I2CBus *bus, uint8_t data);
>  uint8_t i2c_recv(I2CBus *bus);
> =20
> +/**
> + * Create an I2C slave device on the heap.
> + * @name: a device type name
> + * @addr: I2C address of the slave when put on a bus
> + *
> + * This only initializes the device state structure and allows
> + * properties to be set. Type @name must exist. The device still
> + * needs to be realized. See qdev-core.h.
> + */
>  I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
> +
> +/**
> + * Create an I2C slave device on the heap.

Suggest "Create and realize ..."

> + * @bus: I2C bus to put it on
> + * @name: I2C slave device type name
> + * @addr: I2C address of the slave when put on a bus
> + *
> + * Create the device state structure, initialize it, put it on the
> + * specified @bus, and drop the reference to it (the device is realized)=
.
> + * Any error aborts the process.

Stick to imperative mood: Abort on error.

Do we need the sentence?  Doc comments of object_new(), qdev_new() and
i2c_slave_new() don't have it, they document *preconditions* instead,
using "must", and rely on the tacit understanding that a function may
abort or crash when its documented preconditions aren't met.  Matter of
taste, I guess.

> + */
>  I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t=
 addr);
> +
> +/**
> + * i2c_slave_realize_and_unref: realize and unref an I2C slave device

Either consistently waste space for repeating the function name at the
beginning of its doc comment, or consistently don't :)

qdev_realize_and_unref()'s doc comment says "and drop a reference"
instead of "unref", because "unref" is not a word.

> + * @dev: I2C slave device to realize
> + * @bus: I2C bus to put it on
> + * @addr: I2C address of the slave on the bus
> + * @errp: error pointer

$ git-grep -h "@errp:" | sort -u
 *  @errp: pointer to Error*, to store an error if it happens
 * @errp:   error object
 * @errp: Error object
 * @errp: Error object which may be set by job_complete(); this is not
 * @errp: Error object.
 * @errp: If an error occurs, a pointer to an area to store the error
 * @errp: Output pointer for error information. Can be NULL.
 * @errp: Pointer for reporting an #Error.
 * @errp: Populated with an error in failure cases
 * @errp: a pointer to an Error that is filled if getting/setting fails.
 * @errp: a pointer to return the #Error object if an error occurs.
 * @errp: an error indicator
 * @errp: error
 * @errp: error object
 * @errp: error object handle
 * @errp: handle to an error object
 * @errp: if an error occurs, a pointer to an area to store the error
 * @errp: indirect pointer to Error to be set
 * @errp: location to store error
 * @errp: location to store error information
 * @errp: location to store error information.
 * @errp: location to store error, will be set only for exception
 * @errp: pointer to Error*, to store an error if it happens.
 * @errp: pointer to NULL initialized error object
 * @errp: pointer to a NULL initialized error object
 * @errp: pointer to a NULL-initialized error object
 * @errp: pointer to an error
 * @errp: pointer to error object
 * @errp: pointer to initialized error object
 * @errp: pointer to uninitialized error object

Aside: gotta love these two.

 * @errp: returns an error if this function fails
 * @errp: set *errp if the check failed, with reason
 * @errp: set in case of an error
 * @errp: set on error
 * @errp: unused
 * @errp: where to put errors

Plenty of choice, recommend not to invent another one :)

> + *
> + * Call 'realize' on @dev, put it on the specified @bus, and drop the
> + * reference to it. Errors are reported via @errp and by returning
> + * false.

Recommend to use a separate paragraph for the return value.  Since your
comment style resembles GTK-Doc style[*], you may just as well use it
for the return value, like this:

      Returns: %true on success, %false on failure.

By convention, it goes after the function description.

> + *
> + * This function is useful if you have created @dev via qdev_new(),
> + * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
> + * the device it returns to you), so that you can set properties on it
> + * before realizing it. If you don't need to set properties then
> + * i2c_slave_create_simple() is probably better (as it does the create,
> + * init and realize in one step).
> + *
> + * If you are embedding the I2C slave into another QOM device and
> + * initialized it via some variant on object_initialize_child() then
> + * do not use this function, because that family of functions arrange
> + * for the only reference to the child device to be held by the parent
> + * via the child<> property, and so the reference-count-drop done here
> + * would be incorrect.  (Instead you would want i2c_slave_realize(),
> + * which doesn't currently exist but would be trivial to create if we
> + * had any code that wanted it.)
> + */

The advice on use is more elaborate qdev_realize_and_unref()'s.  That
one simply shows intended use.  I doubt we need more.  But as the person
who wrote qdev_realize_and_unref(), I'm singularly unqualified judging
the need ;)

>  bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **err=
p);
> =20
>  /* lm832x.c */


[*] A style I dislike, but it's common in QEMU, so you're certainly
entitled to use it.


