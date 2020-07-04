Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECCBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CCD20702
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDZn9qxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CCD20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkfT-0000It-K1
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrkcx-0004qh-OL
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:02:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrkcr-0005Zp-Vf
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593878568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyg8hvvgF3eclsWpLWVVU9/tb8XxOwjcxhIFzEeq7o4=;
 b=DDZn9qxVbfXMS7rjqQkERo90AnJXxBclCSmZgFzEKxIOo2RdLkY/Bs4ojqx8O6VdHtPN2I
 6zmFTPZzeQl/SXUa4H/EWA7gX3hZ+bBxV7XumTC9CmnozwfOvQJaziTNQIMq7ViRpM5qIw
 9CH5Fx5nYV142dDsqIzEFzqdWFVL1uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-vCYDMWYhNPeGskc1ZHJ_9g-1; Sat, 04 Jul 2020 12:02:46 -0400
X-MC-Unique: vCYDMWYhNPeGskc1ZHJ_9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742CEBFC3;
 Sat,  4 Jul 2020 16:02:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBEB49CA0;
 Sat,  4 Jul 2020 16:02:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6660C1138648; Sat,  4 Jul 2020 18:02:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 26/44] qom: Put name parameter before value / visitor
 parameter
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-27-armbru@redhat.com>
 <d0835559-57c1-d959-d048-df43cd0402af@virtuozzo.com>
 <38a7fce2-462a-0165-b444-d4b14197380c@virtuozzo.com>
Date: Sat, 04 Jul 2020 18:02:43 +0200
In-Reply-To: <38a7fce2-462a-0165-b444-d4b14197380c@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 3 Jul 2020 21:06:24 +0300")
Message-ID: <87v9j3l13w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 03.07.2020 21:05, Vladimir Sementsov-Ogievskiy wrote:
>> 02.07.2020 18:49, Markus Armbruster wrote:
>>> The object_property_set_FOO() setters take property name and value in
>>> an unusual order:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 void object_property_set_FOO(Object *obj, FOO_=
TYPE value,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name, Er=
ror **errp)
>>>
>>> Having to pass value before name feels grating.=C2=A0 Swap them.
>>>
>>> Same for object_property_set(), object_property_get(), and
>>> object_property_parse().
>>>
>>> Convert callers with this Coccinelle script:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0 identifier fun =3D {object_property_get, objec=
t_property_parse, object_property_set_str, object_property_set_link, object=
_property_set_bool, object_property_set_int, object_property_set_uint, obje=
ct_property_set, object_property_set_qobject};
>>> =C2=A0=C2=A0=C2=A0=C2=A0 expression obj, v, name, errp;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 fun(obj, v, name, errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 fun(obj, name, v, errp)
>>
>> I'd suggest
>>
>> @@
>> identifier fun =3D {object_property_get, object_property_parse, object_p=
roperty_set_str, object_property_set_link, object_property_set_bool, object=
_property_set_int, object_property_set_uint, object_property_set, object_pr=
operty_set_qobject};
>> parameter obj, v, name, errp;
>> @@
>> -=C2=A0=C2=A0=C2=A0 fun(obj, v, name, errp)
>> +=C2=A0=C2=A0=C2=A0 fun(obj, name, v, errp)
>>  =C2=A0=C2=A0=C2=A0=C2=A0 {...}
>>
>>
>> in addition, to not
>
> do it by hand I mean

Updating the function comments remains manual, as is tweaking line
breaks for saner diffs.  Not sure the additional automation is worth the
trouble here.

>>> Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
>>> message "no position information".=C2=A0 Convert that one manually.
>>>
>>> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
>>> ARMSSE being used both as typedef and function-like macro there.
>>> Convert manually.
>>>
>>> Fails to convert hw/rx/rx-gdbsim.c, because Coccinelle gets confused
>>> by RXCPU being used both as typedef and function-like macro there.
>>> Convert manually.=C2=A0 The other files using RXCPU that way don't need
>>> conversion.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> The change should be safe, as compiler will complain if something is not=
 updated correspondingly. The only exclusion are object_property_parse and =
object_property_set_str, where both key and value are strings. Check them p=
resizely looking at
>>
>>  =C2=A0vimdiff <(git grep object_property_parse HEAD^ | sed 's/HEAD\^://=
') <(git grep object_property_parse)
>>
>> and
>>
>>  =C2=A0vimdiff <(git grep -A 1 object_property_set_str HEAD^ | sed 's/HE=
AD\^://') <(git grep -A 1 object_property_set_str)
>>
>> seems everything is updated.
>>
>> Also, looked through manual changes for hw/arm/musicpal.c, hw/arm/armsse=
.c and hw/rx/rx-gdbsim.c. Seems correct..
>>
>>
>>> ---
>>> =C2=A0 include/hw/audio/pcspk.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +=
-
>>> =C2=A0 include/qom/object.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 45 ++++-----
>>> =C2=A0 include/qom/qom-qobject.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
>>> =C2=A0 backends/cryptodev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
>>
>> [..]
>>
>>> =C2=A0 static void property_release_tm(Object *obj, const char *name,
>>> @@ -2384,10 +2375,8 @@ static void property_set_uint8_ptr(Object *obj, =
Visitor *v, const char *name,
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *field =3D opaque;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t value;
>>> -=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>
>> This (and some more) chunks are obviously from some another patch..

Looks like a rebase went awry.  I'll regenerate the patch.  Thanks!

>>> -=C2=A0=C2=A0=C2=A0 if (!visit_type_uint8(v, name, &value, &local_err))=
 {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, local=
_err);
>>> +=C2=A0=C2=A0=C2=A0 if (!visit_type_uint8(v, name, &value, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>
>> To find problems like this, I'm trying to rerun your cocci-script, but I=
 don't know how exactly do you run it.
>>
>> I've tried --use-gitgrep, but it doesn't find some files.
>>
>> I've tried
>> git grep -l 'object_property_get\|object_property_parse\|object_property=
_set_str\|object_property_set_link\|object_property_set_bool\|object_proper=
ty_set_int\|object_property_set_uint\|object_property_set\|object_property_=
set_qobject' | xargs spatch script.cocci --macro-file scripts/cocci-macro-f=
ile.h --in-place --no-show-diff
>>
>> Still, have not updated target/arm/monitor.c, strange..

When that happens, Running spatch one more time works sometimes.

Alternatively, you can run it once per file, like this:

    f=3D; for i in  ...
    do
        spatch --sp-file object_property_set.cocci --macro-file scripts/coc=
ci-macro-file.h ... $i || f=3D"$f $i"
    done
    [ "$f" ] && echo "*** FAILED:$f"
    [ -z "$f" ]

Mitigates another issue I have with spatch: it occasionally runs amok
eating up all my RAM.  Seems to be much less likely when I feed it just
one file at a time.

Mind, just because this helps with my version of spatch doesn't mean
it'll help (or even work) with yours.

>> Another fact, which makes it hard to check the patch is a lot of manual =
wrapping/indenting updates.. Hmm, I need some tool or script to make it sim=
ple to compare commits ignoring wrapping and indentation differences.

Try git-diff --word-diff=3Dcolor for visual inspection, =3Dporcelain for
feeding to a script.


