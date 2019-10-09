Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6601CC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ECD206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ECD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIFh-0007c9-15
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@pond.sub.org>) id 1iIH13-0002qc-AL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@pond.sub.org>) id 1iIH0z-0007Jq-Pf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:48:52 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15]:52264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1iIH0z-0007HF-1l
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:48:49 -0400
Received: from blackfin.pond.sub.org
 (p200300D36F484800DACB8AFFFEE0C842.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f48:4800:dacb:8aff:fee0:c842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 1784E4A64F;
 Wed,  9 Oct 2019 20:48:45 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1150A1138619; Wed,  9 Oct 2019 20:48:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 01/31] errp: rename errp to errp_in where it is
 IN-argument
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-2-vsementsov@virtuozzo.com>
 <878spvmwns.fsf@dusky.pond.sub.org>
 <8f936e58-988f-b5af-266d-4230a477ada4@virtuozzo.com>
 <87v9szjvcx.fsf@dusky.pond.sub.org>
 <155beb1a-b50f-4ee0-ec19-4a71f620de79@virtuozzo.com>
Date: Wed, 09 Oct 2019 20:48:42 +0200
Message-ID: <87imoxzred.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 94.130.129.15
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 08.10.2019 15:05, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> 
>>> 08.10.2019 12:08, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> Error **errp is almost always OUT-argument: it's assumed to be NULL, or
>>>>> pointer to NULL-initialized pointer, or pointer to error_abort or
>>>>> error_fatal, for callee to report error.
>>>>
>>>> Yes.
>>>>
>>>>> But very few functions instead get Error **errp as IN-argument:
>>>>> it's assumed to be set, and callee should clean it.
>>>>
>>>> What do you mean by "callee should clean"?  Let's see below.
>>>>
>>>>> In such cases, rename errp to errp_in.
>>>>
>>>> I acknowledge that errp arguments that don't have the usual meaning can
>>>> be confusing.
>>>>
>>>> Naming can help, comments can help, but perhaps we can tweak the code to
>>>> avoid the problem instead.  Let's see:
>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> [...]
>>>> We can avoid the confusing Error **errp in all three cases by peeling
>>>> off an indirection.  What do you think?
>>>>
>>>
>>> I like the idea, thanks! I think, I'll try to make a patch.
>>>
>>> But you are right, unfortunately there more cases, at least, pointed by
>>> Greg
>>>
>>> error_append_socket_sockfd_hint and
>>> error_append_security_model_hint
>>>
>>> Which don't free error..
>> 
>> Neither do error_append_hint() and error_prepend().
>> 
>> For anything named error_append_FOO_hint() or error_prepend_FOO(),
>> confusion seems unlikely.
>> 
>>>                           But if they append hint, they should always be called
>>> on wrapped errp, accordingly to the problem about fatal_error, so they may
>>> be converted to Error *err too.. Hmm, I should think about the script to find
>>> such functions.
>> 
>> I figure I better read more of your series before I comment on this
>> thought.
>> 
>
> Me trying to find more such functions:
>
> script:
> # cat ../up-fix-error_append_hint/find.py
> #!/usr/bin/env python
> import re
> import sys
>
> ret_type = r'^[^{};#]+( |\*|\*\*)'
> name = r'(?P<name>\w+)'
> args = r'\([^{};#]*Error \*\*errp[^{};#]*\)'
> body_before_errp = r'((?<!errp)[^}]|(?<!^)})*'
>
> caller = '(if ?|assert|' \
>            'error_(v?prepend|get_pretty|append_hint|free|free_or_abort)|' \
>            '(warn|error)_reportf?_err)'
>
> # Match 'caller(errp', 'caller(*errp', 'errp ?'
> access_errp = '(' + caller + r'\(\*?errp|errp \?)'
>
> r = re.compile(ret_type + name + args + '\s*^\{' + body_before_errp + access_errp, re.M)
>
> with open(sys.argv[1]) as f:
>      text = f.read()
>
> for m in r.finditer(text):
>      print(m.groupdict()['name'])
>
>
> search:
> # git ls-files | grep '\.\(h\|c\)$' | while read f; do ../up-fix-error_append_hint/find.py $f; done
> vmdk_co_create_opts_cb

Forwards errp to vmdk_create_extent().

Also asserts errp == NULL, which looks suspicious.  Not your problem.

> error_append_security_model_hint
> error_append_socket_sockfd_hint

Convenience functions to append a canned hint with error_append_hint().
Their name makes confusion unlikely.

> qemu_file_get_error_obj

Returns an error object in an unusual way: error_copy() instead of
error_setg().

Suspicious-looking qemu_file_set_error_obj() nearby: it either stores
@err in @f, or reports it to stderr / current monitor.  Not your
problem.

> hmp_handle_error

Covered by your patch, already discussed.

> qbus_list_bus
> qbus_list_dev

Convenience functions to append hints with error_append_hint().
Function names do not hint at that (pardon the pun).

> kvmppc_hint_smt_possible

Convenience function to append hints with error_append_hint().  Function
name hints weakly.

> vnc_client_io_error

Covered by your patch, already discussed.

> error_handle_fatal
> error_setv
> error_prepend
> error_setg_win32_internal
> error_free_or_abort

Let's not worry about error.c itself.

> vmdk_co_create_opts_cb and qemu_file_get_error_obj are false positives I think

Agree.

