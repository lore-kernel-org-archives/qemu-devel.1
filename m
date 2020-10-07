Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB79C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109A220797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy4M7FIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109A220797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAwk-0003NC-RU
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQAqG-00065D-TU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQAqE-0006sR-Ky
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602082493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddiuB38payEMwfEes7mKTrBeZFuSQ93aiV4yYQX0ChI=;
 b=fy4M7FImupdqcuBpBtFuzvjqV/EcV115DgCfrqllrap0F/aew6XlcOFdopKp1wcyipe5bm
 iHLM5nv2eKc+gvq5F77kAqMJWvdCDC577VTSB6tmB3xEbnxYKN0KR8rJW88X3wVoSSR00u
 +d4G5+a2+Q4xoKUPpTtAv676tC/mXys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-Df6W-xGjPv6yqTMgr99KlQ-1; Wed, 07 Oct 2020 10:54:51 -0400
X-MC-Unique: Df6W-xGjPv6yqTMgr99KlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E37A1835B47
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 14:54:50 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 343805C1BD;
 Wed,  7 Oct 2020 14:54:50 +0000 (UTC)
Subject: Re: [PATCH v5 08/36] qapi: delint using flake8
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-9-jsnow@redhat.com>
 <87imbmih3d.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <699585c8-d063-b48c-05ea-dc4b231ed4b0@redhat.com>
Date: Wed, 7 Oct 2020 10:54:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87imbmih3d.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 4:19 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Petty style guide fixes and line length enforcement.  Not a big win, not
>> a big loss, but flake8 passes 100% on the qapi module, which gives us an
>> easy baseline to enforce hereafter.
>>
>> A note on the flake8 exception: flake8 will warn on *any* bare except,
>> but pylint's is context-aware and will suppress the warning if you
>> re-raise the exception.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   scripts/qapi/.flake8     |  2 ++
>>   scripts/qapi/commands.py |  3 ++-
>>   scripts/qapi/schema.py   |  8 +++++---
>>   scripts/qapi/visit.py    | 16 +++++++++++-----
>>   4 files changed, 20 insertions(+), 9 deletions(-)
>>   create mode 100644 scripts/qapi/.flake8
>>
>> diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
>> new file mode 100644
>> index 00000000000..6b158c68b84
>> --- /dev/null
>> +++ b/scripts/qapi/.flake8
>> @@ -0,0 +1,2 @@
>> +[flake8]
>> +extend-ignore = E722  # Prefer pylint's bare-except checks to flake8's
>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> index 64ed5278f93..5dc2f5a9fa8 100644
>> --- a/scripts/qapi/commands.py
>> +++ b/scripts/qapi/commands.py
>> @@ -65,7 +65,8 @@ def gen_call(name, arg_type, boxed, ret_type):
>>   def gen_marshal_output(ret_type):
>>       return mcgen('''
>>   
>> -static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out, Error **errp)
>> +static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
>> +                                QObject **ret_out, Error **errp)
>>   {
>>       Visitor *v;
>>   
>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> index 093f7a38d88..cfc52e1ae44 100644
>> --- a/scripts/qapi/schema.py
>> +++ b/scripts/qapi/schema.py
>> @@ -536,7 +536,7 @@ def set_defined_in(self, name):
>>               v.set_defined_in(name)
>>   
>>       def check(self, schema, seen):
>> -        if not self.tag_member: # flat union
>> +        if not self.tag_member:  # flat union
>>               self.tag_member = seen.get(c_name(self._tag_name))
>>               base = "'base'"
>>               # Pointing to the base type when not implicit would be
>> @@ -821,7 +821,7 @@ def __init__(self, fname):
>>           self._entity_dict = {}
>>           self._module_dict = OrderedDict()
>>           self._schema_dir = os.path.dirname(fname)
>> -        self._make_module(None) # built-ins
>> +        self._make_module(None)  # built-ins
>>           self._make_module(fname)
>>           self._predefining = True
>>           self._def_predefineds()
>> @@ -965,7 +965,9 @@ def _make_implicit_object_type(self, name, info, ifcond, role, members):
>>               # But it's not tight: the disjunction need not imply it.  We
>>               # may end up compiling useless wrapper types.
>>               # TODO kill simple unions or implement the disjunction
>> -            assert (ifcond or []) == typ._ifcond # pylint: disable=protected-access
>> +
>> +            # pylint: disable=protected-access
>> +            assert (ifcond or []) == typ._ifcond
>>           else:
>>               self._def_entity(QAPISchemaObjectType(
>>                   name, info, None, ifcond, None, None, members, None))
>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index ea277e7704b..808410d6f1b 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -31,7 +31,9 @@ def gen_visit_decl(name, scalar=False):
>>       if not scalar:
>>           c_type += '*'
>>       return mcgen('''
>> -bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_type)sobj, Error **errp);
>> +
>> +bool visit_type_%(c_name)s(Visitor *v, const char *name,
>> +                 %(c_type)sobj, Error **errp);
>>   ''',
>>                    c_name=c_name(name), c_type=c_type)
>>   
>> @@ -125,7 +127,8 @@ def gen_visit_object_members(name, base, members, variants):
>>   def gen_visit_list(name, element_type):
>>       return mcgen('''
>>   
>> -bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
>> +bool visit_type_%(c_name)s(Visitor *v, const char *name,
>> +                 %(c_name)s **obj, Error **errp)
>>   {
>>       bool ok = false;
>>       %(c_name)s *tail;
>> @@ -158,7 +161,8 @@ def gen_visit_list(name, element_type):
>>   def gen_visit_enum(name):
>>       return mcgen('''
>>   
>> -bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error **errp)
>> +bool visit_type_%(c_name)s(Visitor *v, const char *name,
>> +                 %(c_name)s *obj, Error **errp)
>>   {
>>       int value = *obj;
>>       bool ok = visit_type_enum(v, name, &value, &%(c_name)s_lookup, errp);
>> @@ -172,7 +176,8 @@ def gen_visit_enum(name):
>>   def gen_visit_alternate(name, variants):
>>       ret = mcgen('''
>>   
>> -bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
>> +bool visit_type_%(c_name)s
>> +    (Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
> 
> Please break this line the same way as the ones above:
> 
>     bool visit_type_%(c_name)s(Visitor *v, const char *name,
>                      %(c_name)s **obj, Error **errp)
> 
>>   {
>>       bool ok = false;
>>   
>> @@ -247,7 +252,8 @@ def gen_visit_alternate(name, variants):
>>   def gen_visit_object(name, base, members, variants):
>>       return mcgen('''
>>   
>> -bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
>> +bool visit_type_%(c_name)s
>> +    (Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
>>   {
>>       bool ok = false;
> 
> Likewise.
> 

Whupps. Bad conflict resolution on my part. Didn't mean to do this.

--js


